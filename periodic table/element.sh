#!/bin/bash
PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"

#if argument does not exist
if [[ -z $1 ]]
then
echo "Please provide an element as an argument."
exit 0
fi
#check if argument is a number
if [[ $1 =~ ^[0-9]+$ ]]
then
ELEMENT=$($PSQL "select e.atomic_number,e.symbol,e.name,p.atomic_mass,p.melting_point_celsius,p.boiling_point_celsius,t.type from elements e inner join properties p on e.atomic_number=p.atomic_number inner join types t on p.type_id=t.type_id where e.atomic_number=$1;")
	#if element is empty
	if [[ -z $ELEMENT ]]
	then
		echo "I could not find that element in the database."
		exit 0
	#else
	else
		echo $ELEMENT | while read ATOM_NUM BAR SYMBOL BAR NAME BAR ATOM_MASS BAR MELT_POINT BAR BOIL_POINT BAR TYPE
		do
			echo "The element with atomic number $ATOM_NUM is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOM_MASS amu. $NAME has a melting point of $MELT_POINT celsius and a boiling point of $BOIL_POINT celsius."
		done
		exit 0
	fi
fi
#check if it is a valid string
if [[ ! $1 =~ [0-9] ]]
then
ELEMENT=$($PSQL "select e.atomic_number,e.symbol,e.name,p.atomic_mass,p.melting_point_celsius,p.boiling_point_celsius,t.type from elements e inner join properties p on e.atomic_number=p.atomic_number inner join types t on p.type_id=t.type_id where e.symbol='$1' or e.name='$1';")
	#if element is empty
	if [[ -z $ELEMENT ]]
	then
		echo "I could not find that element in the database."
		exit 0
	#else
	else
		echo $ELEMENT | while read ATOM_NUM BAR SYMBOL BAR NAME BAR ATOM_MASS BAR MELT_POINT BAR BOIL_POINT BAR TYPE
		do
			echo "The element with atomic number $ATOM_NUM is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOM_MASS amu. $NAME has a melting point of $MELT_POINT celsius and a boiling point of $BOIL_POINT celsius."
		done
		exit 0
	fi
#if it is not a valid string
else
	echo "I could not find that element in the database."
	exit 0
fi
