----------------------
Line Arguments 
----------------------
1. DATABASE name : invoice_management
2. TABLE names:
		clients
		users
		invoice
		invoice_details
		items
3. The foreign keys were created at once with the tables, therefore I needed to be able to relieve depenencies. 
   line: SET foreign_key_checks = 0, was added


-------------------------
Design Decisions & Issues
-------------------------
Some points of the this project proved more challenging than expected.

Q. What gave you the most trouble?

A. To be quite honest I thought updating would of been a breeze but it proved otherwise. 
   Simple update was achieved quite easily but retaining original information was frankly difficult and was not implemented. 
   I spent an agregious amount of time on this feature alone.  

Q. How much time was spent working on the project?

A. Easily over 35 hours, considering some days I spent nearly 9 hours working on it until my head became mash potato.

Q. What did you think was difficult but proved to be easy/easier?

A. I havent created an actual relational database from scratch since the first module, 
   so I obviously assumed it was going to be hard but was only a tedius task. 

Q. What did you not finish or remains incomplete?

A. The project is not fully done and I believe any project is never fully complete and can always be improved in one way or another
   but if I were to name a big one, it would be triggers. In theory is seem simple and im sure if I tried to implement a trigger for quantity deduction it would work eventually, I just didn't have enough time to get around it.
   Focus in the end was towards fixing existing issues.

-----------------------
Analysis breakdown
-----------------------

These were the steps to the process:
    1 ) Create database
    2 ) Create tables
    3 ) Create diagram 
    4 ) Login user using stored procedure and functions
    5 ) CRUD (users, clients, items, invoices) using stored procedures
    6 ) Find invoices using stored procedures
    7 ) Home page using stored procedures
    8 ) Create new user login (fixed)
    9 ) Create flowchart (invoice details)


------------------------------
Redos and failed attemtps
------------------------------


1 ) There was an enormous amount of failed attemps creating an update that would retain original information without wiping out the data or simply creating null values.
    at first I tried to update all values in one INSERT which would leave non entered values to remain blank. 
    I then tried to use the INSERT on mulitple IF statements to reassure only the names that were not equal to the original name were altered. That attemtp failed as well.
    Lastly I had a few attempts trying with a switch case and while loops but to no avail.

2 ) The user login was an absolute failure of an attempt. I see no reason as to why it was so difficult to implement, perhaps I was burnt on that very moment of the day? 
    needless to say, I attempted it one last time towards the end of the project and it was finished in less than 5 minutes, which was quite satisfying. 
    Only problem was the counter for the lockout was never being read.

3 ) Triggers were never implemented.
 
