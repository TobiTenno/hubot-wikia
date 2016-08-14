# hubot-wikia

##Most of the links on this page referring to the usage, installation, or api will not function currently.

[![NPM](https://nodei.co/npm/hubot-wikia.png?downloads=true&downloadRank=true&stars=true)](https://nodei.co/npm/hubot-wikia/)
[![Build Status](https://travis-ci.org/aliasfalse/hubot-wikia.svg)](https://travis-ci.org/aliasfalse/hubot-wikia/)
[![Stories in Ready](https://badge.waffle.io/aliasfalse/hubot-wikia.png?label=ready&title=Ready)](https://waffle.io/aliasfalse/hubot-wikia)

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

3. Add your domain to your environment with the key `HUBOT_WIKIA_DOMAIN`

4. Run your bot and see below for available config / commands


## Commands

Command | Listener ID | Description
--- | --- | ---
`hubot wikia <query>` | `id:'hubot-wikia.article',` | Returns the first Wikia article matching the search `query`


## Sample Interaction

```
user1>> hubot wikia elytron
hubot>> Elytron : http://warframe.wikia.com/wiki/Elytron
```
