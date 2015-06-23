'use strict'

_ = require 'lodash'
request = require 'request'
url = require 'url'
querystring = require 'querystring'


# Get list of proxys
exports.index = (req, res) ->
  return handleError res, new Error('Wrong querystring')  unless req.query.u

  requestUrl = (new Buffer(req.query.u, 'base64')).toString()
  urlObj = url.parse requestUrl

  jar = request.jar()
  if not _.isEmpty req.cookies
    cookieSite = "#{urlObj.protocol}//#{urlObj.host}"
    for key in Object.keys req.cookies
      jar.setCookie request.cookie("#{key}=#{req.cookies[key]}"), cookieSite

  request(
    'method': 'GET'
    'url': requestUrl
    'jar': jar
    # Proxy List: http://www.proxylists.net/kr_0.html
    'proxy': 'http://112.150.156.223:3128'
    #'proxy': 'http://211.237.218.26:3128'
    #'proxy': 'http://221.149.14.70:8080'
    #'proxy': 'http://211.236.185.151:1080'
  ).on('error', (err) ->
    handleError res, err
  ).pipe(res)

handleError = (res, err) ->
  res.status(500).send err.message