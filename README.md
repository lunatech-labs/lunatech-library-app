# Library-app

*****Lunatech’s Library application*****

*This app consists of a backend in Java and frontend in Elm. It provides a service for the administration of books and their lend-outs.*


### Owner

Emile Verschuren is the creator of this application. Any remarks, questions at emile.verschuren@lunatech.nl.

### Authentication

The authentication takes place via google Oauth. Note that only emails from lunatech-domains (fr,be,nl) are allowed.

## Backend


### Technical

This backend is made with Java, Spring Boot, JPA, Hibernate, Swagger. The data is persisted in a Post-gres database, unit tests take place in a volatile H2 database.


### Resources

Github:				`https://github.com/lunatech-labs/lunatech-library-app`

clever cloud: `http://library.lunatech.com/`

swagger-ui:		`<base-url>/swagger-ui.html`


### Environment variables

•	`GOOGLE_OAUTH2_CLIENT_ID`

The client-id provided by Google. The string I am looking at is 72 characters long and ends with “apps.googleusercontent.com”.

•	`GOOGLE_OAUTH2_CLIENT_SECRET`

The secret provided by Google. This string is 24 characters long.

•	`POSTGRES_DATASOURCE_URL`

The url to get access to the postgress database. 

•	`POSTGRES_DATASOURCE_USERNAME`

•	`POSTGRES_DATASOURCE_PASSWORD`


### Setup

•	Import the repository in your favorite IDE (IntelliJ, Eclipse, etc).

•	In Google Cloud Console obtain an Api key and activate Oauth 2 to get a Client Id and a secret

•	Install Postgres

•	In your workstation, or better in your IDE administer the environment variables


### Documentation

See the swagger-ui for the endpoints and model.


## Frontend

### Technical

This frontend is coded in Elm 0.19.1.

### Resources

Github:				`https://github.com/lunatech-labs/lunatech-library-app/frontend`

### Environment variables in env.js

Currently the environment variables are stored into the Javascript-file env.js in the root folder of the frontend. This file is not included in this repository.
For convenience, an example of the env.js.

```
var flags='\
    {\
        "google_oauth2_client_id" :   "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"\
        ,"library_api_base_url"   :   "YYYYYYYYYYYYYYYYYYYY"\
        ,"this_base_url"          :   "ZZZZZZZZZZZZZZZZZZZZZZ"\
    }'
```

### Starting up
Supply the abovementioned env.js with the correct values.
In the root folder of the frontend enter :

```
elm-live src/Main.elm --open --start-page=src/resources/index.html -- --output=main.js
```
The application will appear in your browser at :
```
http://localhost:8000/
```
