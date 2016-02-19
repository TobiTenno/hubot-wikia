var request = require('request');
var Wikia = require('node-wikia');
var domain = process.env.WIKI_DOMAIN;

exports.wikiaSearch = function(query, callback) {
  var formData = {query: query, limit: 1};
  var pedia = new Wikia(domain);
  
  try{
      var data = pedia.getSearchList(formData);
      if(data.state){
      	console.log(data);
        callback(null, "No results");
      }
      callback(null, pedia.getSearchList(formData).items[0]);
  } catch (err) {
      callback(err, null);
  }
}

exports.wikiaSummary = function(query, callback) {
  var formData = {query: query, limit: 1};
  
  var pedia = new Wikia(domain);
  
  try{
      callback(null, pedia.getSearchList(formData).items[0].url,pedia.getArticleAsSimpleJson(pedia.getSearchList(formData).items[0]).sections[0]);
  } catch (err) {
      callback(err, null);
  }
}
