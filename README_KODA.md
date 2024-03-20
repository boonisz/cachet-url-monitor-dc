# Goals
- [ ] web dashboard to view status of apps in the koda infrastructure
- [ ] notificatins when errors occur

Questions

Cachet doesn't monitor, it just displays errors that were sent to it,
and people can subscribe to those error events.
So should we setup a monitoring service? Cachet has some third-party recommendations: [https://docs.cachethq.io/integrations]()

```mermaid
graph TD;
    C[Status Web Dashboard] --> A[PHP Backend] --> B(Cachet PostgreSQL DB)
    A --> D[mailgun stmp service] --> E[kodacachet@gmail.com]
    A --> F[koda]
```

# How to run
`docker-compose up` then open `http://localhost:80/dashboard` in a web browser

##### dev mode:
```yml
# docker-compose.yml
environment:
  - APP_ENV=${APP_ENV:-local}
  - APP_DEBUG=true
```

### Create an api key for the php server

```sh 
# open terminal in the cachet php container 
docker exec -it ${docker ps --filter "ancestor=docker-cachet" --format "{{.ID}}"} bash
```
```sh
# Generate APP_KEY
php artisan key:generate --show
```
```shell
# set APP_KEY in .env
vi .env
# APP_KEY=base64:generated_key_here
```
```shell
# reload .env
php artisan config:cache

# If you experience any issues after running this command, run this too:
rm -rf bootstrap/cache/*
```

`APP_KEY` can also be set in [docker-compose.yml]()
```yaml
environment:
  - APP_KEY=base64:generated_key_here
```

### Send a notification
1. Get `API_TOKEN` token from [http://localhost/dashboard/user](http://localhost/dashboard/user)
2. set the `X-Cachet-Token header`, and `component_id json property` in [send_notification.sh](send_notification.sh) and run it

For more, see the API [https://docs.cachethq.io/api/]()

# Email notifications
Email notifications are sent with [mailgun](https://www.mailgun.com/)
- account name: enfuse.io
- email: tcr@enfuse.io
- password: 1G1NQ^U4qIX$uEh0

The free version of mailgun can only have 5 recipients, and they must be registered
- so far, the only registered email is kodacachet@gmail.com
- gmail password is: qG^lrK7U1jbfDf^@

# TODO
- [ ] change postgres port to non-default to avoid conflicting with the sidekick postgres db
- [ ] change front end url from `80` to something else to avoid conflicts with other web services defaulted to `80`
- [ ] start showing status of a component (db, http api, rtsp server)
- Connect apis
    - add health checks
        - [ ] sidekick
        - [ ] tracking
        - [ ] hls converter(s)
        - [ ] check if mediamtx has one built in
    - notification clients
        - [x] choose client libraries from [https://docs.cachethq.io/client-libraries]()
        - [x] implement in publishers of status notifications
- long term
    - [ ] how to update (show link to updating git repo instead of using tags from dockerhub)
      optional
        - [ ] setup ability to subscribe to email notifications [https://docs.cachethq.io/configuration/subscribers]()