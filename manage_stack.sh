#!/bin/bash


# Description: Script to create or update AWS CloudFormation Stacks
# Author: Nicolas Neuburger
# Last Updated: 06th of April 2020

# Declare Variables
COMMAND="create-stack"

# User Feedback in case of wrong usage

function usage()
{
    echo "manage_stack.sh STACK_NAME TEMPLATE_FILEPATH PARAMETERS_FILEPATH"
    echo ""
    echo "./manage_stack.sh"
    echo "\t-h --help"
    echo "\t--update=Updates an existing stack"
    echo "\t-h | --help shows this helper information"
    echo ""
}


while [[ $1 = -* ]]; do

    PARAM=`echo $1 | awk -F= '{print $1}'`

    case $PARAM in
        -h | --help)
            usage
            exit
            ;;
        -u | --update)
            COMMAND="update-stack"
            ;;
        *)
            echo "Error unknown parameter \"$PARAM\""
            usage
            exit 1
            ;;

    esac
    shift
done

aws cloudformation $COMMAND --stack-name $1 --template-body file://$2 --parameters file://$3 --region eu-central-1
