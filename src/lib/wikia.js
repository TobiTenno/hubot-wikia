var request = require('request');
var Wikia = require('node-wikia');


exports.wikiaSearch = function(query, callback, domain) {
  var formData = {query: query, limit: 1};
  var pedia = new Wikia(domain);
  
  try{
      callback(null, pedia.getSearchList(formData).items[0]);
  } catch (err) {
      callback(error, null);
  }
}

exports.wikiaSummary = function(query, domain, callback) {
  var formData = {query: query, limit: 1};
  
  var pedia = new Wikia(domain);
  
  try{
      callback(null, pedia.getSearchList(formData).items[0].url,pedia.getArticleAsSimpleJson(pedia.getSearchList(formData).items[0]).sections[0]);
  } catch (err) {
      callback(error, null);
  }
}
