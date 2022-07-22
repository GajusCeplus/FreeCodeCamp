#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"
RANDOM_NUMBER=$(($RANDOM%1000 + 1))

#game loop
GAME(){
  MOVES_COUNT=0
  GUESSED_NUMBER=0
  #get user id to save game $1 the username
  GET_USERNAME_ID=$($PSQL "select username_id from usernames where username='$1'")
  echo "Guess the secret number between 1 and 1000:"
  while [[ $GUESSED_NUMBER -ne $RANDOM_NUMBER ]]
  do
    read GUESSED_NUMBER
    #check if the input is an integer
    if [[ $GUESSED_NUMBER =~ ^[0-9]+$ ]]
    then
      #if it is moves_count++
      ((MOVES_COUNT++))
      #check if the guess is correct
      #too big
      if [[ $GUESSED_NUMBER -gt $RANDOM_NUMBER ]]
      then
        echo "It's lower than that, guess again:"
      #correct guess
      elif [[ $GUESSED_NUMBER -eq $RANDOM_NUMBER ]]
      then
        echo "You guessed it in $MOVES_COUNT tries. The secret number was $RANDOM_NUMBER. Nice job!"
        INSERT_GAME_RESULT=$($PSQL "insert into games (moves,username_id) values ($MOVES_COUNT,$GET_USERNAME_ID)")
      #too small
      else
        echo "It's higher than that, guess again:"
      fi
    #input is not a number
    else
      echo "That is not an integer, guess again:"
    fi
  done
}

#get username
echo "Enter your username:"
read USERNAME

#check if username exitsts in database
CHECK_USERNAME=$($PSQL "select username from usernames where username='$USERNAME'")
if [[ -z $CHECK_USERNAME ]]
then
  #if not add it and print welcome message
  INSERT_USERNAME_RESULT=$($PSQL "insert into usernames (username) values ('$USERNAME');")
  if [[ $INSERT_USERNAME_RESULT == "INSERT 0 1" ]]
  then
    echo "Welcome, $USERNAME! It looks like this is your first time here."
    #Start game
    GAME $USERNAME
  else
    echo "The username is too short!"
  fi  
else
  #if it does print welcome message
  GET_USER_DATA=$($PSQL "select username,count(game_id),min(moves) from games g inner join usernames u on g.username_id=u.username_id where username='$USERNAME' group by username;")
  echo $GET_USER_DATA | while IFS="|" read USERNAME GAMES_PLAYED BEST_GAME
  do
  echo "Welcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."
  done
  #Start game
  GAME $USERNAME
fi
