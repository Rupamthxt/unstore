
# Unstore

Unstore is a self hosted photo storing  platform that allows users from android devices to store images from their devices into a raspberry pi server to maintain privacy while ensuring robust access. 




[![MIT License](https://img.shields.io/badge/License-MIT-green.svg)](https://choosealicense.com/licenses/mit/)



## Deployment

To run this project

Download the project as zip and open the Unstore folder with an IDE for executing the android application.

Copy the server folder to any location of your Raspberry pi

In the terminal run
```bash
  npm install
```
This installs all the node modules needed for the project.

Now get a domain of your own choice (I had used [Spaceship](https://www.spaceship.com/) for their really cheap first year plans), & go on to [Cloudflare](https://www.cloudflare.com/), create an account.

Change the nameservers of the domain and add it to your cloudflare account. Once it is live, that is cloudflare shows it as live create a tunnel install the connectors in the Pi and add your domain to the public host name and 

```
  localhost:5000
```
in the service section, set the service type to be HTTP 

In the main.dart file change the urls marked TODO to your own URL.

Go to the pi terminal, navigate to the folder where the server is setup and run
```bash
  which node
```
This would spit out the location of your node executable

In order to run the server automatically on every reboot we need to setup the crontab

Now run
```bash
  crontab -e
```
This would open the crontab file for editing at the very last add 

```bash
  @reboot (/bin/sleep 30; /path/to/your/node /path/to/your/server/file &)
```

In my case path to my node executable was
```
  /usr/bin/node
```
Now save the file.

In the terminal run
```bash
  node server.js
```
This should make the server up and running. Go to a browser and search for your domain if it returns a message as __Hello__ the the server is ok and all set.

Fire up the application by running 

```dart
  flutter run
```
in any IDE and the application should be ready to be used.
