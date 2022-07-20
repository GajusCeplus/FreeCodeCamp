#! /bin/bash
PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"

echo -e "\n~~~~~ MY SALON ~~~~~\n"

MAIN_MENU(){
  if [[ $1 ]]
  then
    echo -e "\n$1"
  fi
  echo -e "\nWelcome to My Salon, how can I help you?\n"
  AVAILABLE_SERVICES=$($PSQL "select * from services")
  echo "$AVAILABLE_SERVICES" | while read SERVICE_ID BAR NAME
  do
    echo "$SERVICE_ID) $NAME"
  done
  MAKE_APPOINTMENT
}
MAKE_APPOINTMENT(){
  read SERVICE_ID_SELECTED
  #if it's not a number
  if [[ ! $SERVICE_ID_SELECTED =~ ^[0-9]+$ ]]
  then
    #send to main menu
    MAIN_MENU "Please, select valid number option."
  else
    GET_SERVICE=$($PSQL "select name from services where service_id=$SERVICE_ID_SELECTED")
    #if selected number is not a valid option
    if [[ -z $GET_SERVICE ]]
    then
      MAIN_MENU "I could not find a service with that number"
    else
      echo -e "\nWhat's your phone number?"
      #Get customer's phone number
      read CUSTOMER_PHONE
      #find customer in database
      CUSTOMER_NAME=$($PSQL "select name from customers where phone='$CUSTOMER_PHONE'")
      #if name not found
      if [[ -z $CUSTOMER_NAME ]]
      then
        #get new name
        echo -e "\nI don't have a record for that phone number, what's your name?"
        read CUSTOMER_NAME
        INSERT_CUSTOMER_RESULT=$($PSQL "insert into customers (phone,name) values ('$CUSTOMER_PHONE','$CUSTOMER_NAME')")
      fi
      echo -e "\nWhat time would you like your cut,$CUSTOMER_NAME?"
      #get time
      read SERVICE_TIME
      #insert appointment
      CUSTOMER_ID=$($PSQL "select customer_id from customers where phone='$CUSTOMER_PHONE'")
      INSERT_APPOINTMENT_RESULT=$($PSQL "insert into appointments (customer_id,service_id,time) values ($CUSTOMER_ID,$SERVICE_ID_SELECTED,'$SERVICE_TIME')")

      SERVICE_TIME_FORMATTED=$(echo $CUSTOMER_NAME | sed 's/ |//')
      echo -e "\nI have put you down for a $(echo $GET_SERVICE | sed 's/ |//') at $(echo $SERVICE_TIME | sed 's/ |//'), $(echo $CUSTOMER_NAME | sed 's/ |//')."
    fi
  fi
}
MAIN_MENU