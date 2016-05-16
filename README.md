[![Stories in Ready](https://badge.waffle.io/aliasfalse/hubot-wikia.png?label=ready&title=Ready)](https://waffle.io/aliasfalse/hubot-wikia)
# hubot-wikia

##Most of the links on this page referring to the usage, installation, or api will not function currently.

[![Build Status](https://travis-ci.org/aliasfalse/hubot-wikia.svg)](https://travis-ci.org/aliasfalse/hubot-wikia/)

A Hubot script for interacting with [Wikia's API](http://www.wikia.com/api/v1/) (searching for articles and returning extracts).

See [`src/wikia.coffee`](src/wikia.coffee) for full documentation.


## Installation via NPM

1. Install the __hubot-wikia__ module as a Hubot dependency by running:

    ```
    npm install --save hubot-wikia
    ```

2. Enable the module by adding the __hubot-wikia__ entry to your `external-scripts.json` file:

    ```json
    [
        "hubot-wikia"
    ]
    ```

3. Run your bot and see below for available config / commands


## Commands

Command | Listener ID | Description
--- | --- | ---
hubot wikia `query` | `/wikia(.+)/` | Returns the first Wikia article matching the search `query`


## Sample Interaction

```
user1>> hubot wikia elytron
hubot>> 
```
