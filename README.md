# This is a PostgreSQL setup which can be used as a local database.

## Features
- support for uuidv7
- use of secret inplace of direct exposure to password in docker file
- creation of non root user
- addition of extension which support rest api development

## It has two service
- Database (17.4)
- Admirer (5.1.0)


### Important commands
- First build custom postgres image with uuidv7 support `docker-compose build --no-cache`
- To start the container `docker-compose up -d`
- To view status of container `docker ps`

### DB Connection string
`postgresql://my_app_user:pa55word@localhost:5432/datamover?sslmode=disable`

### Reference
[Youtube](https://youtu.be/EhapnaEKl-w?si=0VTfg76L33E5rFob)
