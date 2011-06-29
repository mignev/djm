#!/bin/bash

function djm {

    if [ "$1" == "sm" ]; then
        APPNAME="$(the_django_appname $2)"
        manage_py schemamigration "$APPNAME" --auto;
        return 0
    fi

    if [ "$1" == "m" ]; then
        APPNAME="$(the_django_appname $2)"

        if [ "$APPNAME" == "NoNameError" ]; then
            manage_py migrate
        else
            manage_py migrate "$APPNAME"
        fi
        
        return 0
    fi

    if [ "$1" == "mm" ]; then
        APPNAME="$(the_django_appname $2)"
        manage_py schemamigration "$APPNAME" --auto;
        manage_py migrate "$APPNAME"
        return 0
    fi

    if [ "$1" == "mi" ]; then
        APPNAME="$(the_django_appname $2)"
        manage_py schemamigration "$APPNAME" --initial;
        return 0
    fi

    if [ "$1" == "dbto" ]; then

        APPNAME="$(the_django_appname $2)"
        if [ -e "models.py" ]; then
            MYDIR=$(dirname `pwd`)
        else
            MYDIR=$(pwd)
        fi

        ALLDBFILES=$(ls $MYDIR |grep db)

        if [ "$APPNAME" == "NoNameError" ]; then
            echo "Enter the appname!";
            return 0
        fi
        for file in $ALLDBFILES
        do
            ln -s $MYDIR/$file $MYDIR/$APPNAME/$file
            echo "Creating symlink from $MYDIR/$file to $MYDIR/$APPNAME/$file"
            if [ -e "$MYDIR/$APPNAME/$file" ]; then
                echo "Done!"
            else
                echo "Sorry ... file does not exist!"
            fi
        done

        return 0
    fi
    
    manage_py "$@"
    return 0
}

function the_django_appname {
    if [ -z "$1" ]; then
        if [ -e "models.py" ]; then
            APPNAME=$(basename `pwd`)
            echo $APPNAME;
        else
            echo "NoNameError"
            exit 0
        fi
    else
        echo $1;
    fi
}

function manage_py {

    if [ ! -f "manage.py" ]; then
        if [ ! -f "models.py" ]; then
            echo "Please go to some Django application directory :)"
            return 0
        fi  
    fi  
    
    if [ -z "$1" ]; then
        ARGS="help"
    else
        ARGS="$@"
    fi

    if [ -e "manage.py" ]; then
        python manage.py $ARGS;
    else
        if [ -e "models.py" ]; then
            python ../manage.py $ARGS;
        fi
    fi
}
