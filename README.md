#Django manage.py aliases

##Loading

    source djm.sh

#Examples
So ...

    $ djm --> python manage.py
    
    $ djm help --> python manage.py help

If you use `south` for database migrations following aliases will be useful for you:
    
    #if you are in you appname directory for example mysite/PollsApp
    
    $ djm mi --> python manage.py schemamigration PollsApp --initial
    $ djm sm --> python manage.py schemamigration PollsApp --auto
    $ djm m  --> python manage.py migrate PollsApp
    $ djm mm --> python manage.py schemamigration PollsApp --auto && python manage.py migrate PollsApp

    #if you are outside of your app dir for example mysite/ you must use the aliases with appname

    $ djm mi PollsApp --> python manage.py schemamigration PollsApp --initial
    $ djm sm PollsApp --> python manage.py schemamigration PollsApp --auto
    $ djm m  PollsApp --> python manage.py migrate PollsApp
    $ djm mm PollsApp --> python manage.py schemamigration PollsApp --auto && python manage.py migrate PollsApp
