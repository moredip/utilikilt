# Get Going!
install the dependencies you need with:
```
bundle install --path vendor/bundle --binstubs
```

Install pow, your friendly static server)
```
curl get.pow.cx | sh
```

Use powder to ask pow to serve up the files in the *public* subdirectory:
```
bin/powder link
```

Fire up **Guard** which will magically generate HTML and CSS whenever you change your HAML and SASS:
```
bin/guard
```

Open up your content in a web browser:
```
bin/powder open
```
