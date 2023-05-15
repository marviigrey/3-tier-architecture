

A three-tier architecture application is a software architecture that divides an application into three logical layers or tiers, each with a specific role and set of responsibilities. 

The three tiers are typically:

1. Presentation Tier: This is the user-facing layer of the application, responsible for handling user interactions and presenting data to the user. It often includes a graphical user interface (GUI) or web interface that allows users to interact with the application.

2. Application Tier: This is the business logic layer of the application, responsible for processing user requests and managing application data. It often includes a server or middleware layer that performs tasks such as authentication, authorization, and application logic.

3. Data Tier: This is the data storage layer of the application, responsible for managing application data and ensuring its integrity. It often includes a database server or other data storage system that stores and retrieves data as needed.

The three-tier architecture is a popular design pattern for web applications, as it allows for scalability, modularity, and flexibility in the development and deployment of complex software systems.

We create two EC2-Instances,for database and web server. After this,we create 6 EBS volumes of 10 GB each and attach them to our instances. Moving forward,we setup our webserver by following the steps in the partition.sh scripts to configure our web server. each process is explained in the script, we do setup both our db and webserver.
After configuring and setting up our ec2-instance and storage subsystems, we move forward to install our db which mysql on the database server and wordpress,mysql-client,php,apache on our web server. We created a simple database called wordpress and assigned a user to the database on our db server,also configure our db server to work with our wordpress.
we move the wordpress into the apache /var/www/html directory to display our site dashboard.
NOTE: On our db server security group,we ensure that an inbound rule allowing only port 3306 and setting only our web server to connect to our db by specifying the IP.
For the web server,we ensure port 80 is open only,so we can be able to access wordpress dashboard through the <web-server-public-IP>:80/wordpress.
  
