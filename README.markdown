Polar
===================

### About
Polar is an API wrapper for the Renren social network. This gem is a fork of the renren-api gem. Thanks to Lei Zhi-Qiang for the great work on the renren-api gem. This fork does a number of things differently such as using faraday under the hood and always returning domain objects in preference to hashes.

### Installation
Polar is a cool name(excuse the pun) but it was already taken on ruby gems so you will have to install polar with the following line in your Gemfile.

```ruby
gem "polar-renren", :require => "polar"
```

Not using bundler? Well you should but thats cool.

```ruby 
gem intsall polar-renren
#then in your code
require 'polar'
```

### Useage
In polar you use the client object to interact with the api. To create the client you will need to know three different things. Firstly you will need an application key and an application secret. To get these you will need to visit the renren developer site and create an application. Once you have created the application you can go in to the applications control panel and grab the secret and key. As well as these you will need a session key. To get a session key you must login first. This can be done with OAuth2 as renren provides this feature. There is an omni-auth stragity that exists provided by Scott Ballantyne that works well.

```ruby
client = Polar::Client.new(app_key, app_secret, session_key)
```

License
===================
Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
