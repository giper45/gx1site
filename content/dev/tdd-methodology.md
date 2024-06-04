+++
title = 'Test Driven Development Methodology'
date = 2024-06-04T08:46:33+02:00
draft = false
tags = ["dev", "software development", "nodejs", "testing"]
+++

Test driven development methodology is aimed at improving software modularity by using an approach based on writing tests before writing program code. 

## Methodology principle 

The principle is very simple: when you develop you always try to test with example data, which is taken and printed. You use console.log until you solve the problem. 

Imagine that you write an operations.js library that has various functions including an addition: 

```javascript
const add = (a,b) => a + b
```

This function we should try to see if it returns valid results. 

Usually what do we do? We use a main module that imports the library and try it with dummy data: 


```javascript
const operations = require('operations') 

const result = add(3, 4)
console.log(result) 
```

We see that the result is 7 and we are satisfied. 

Here, the principle behind TDD is to systematize this process.

Instead of writing code in the main, we create a test folder and insert modules inside to test the various functions of the operation module


```javascript
// test/operations_test.js
const ops = require('operations')
describe('wg', function () {
    it('should return valid result', function () {
      assert.equal(ops.add(3, 4), 7)
    });
    ...
  });
  ```


In this way, we can check the correct operation of the code , and this test remains fixed even when we change the conditions of use of the library. For example, having written a function for division, we might check for a bug in this “division” function in the operations module we wrote.  In particular, a division cannot be done by 0. Assume that it returns -1 when the divisor is 0. Suppose the code looked like this: 

```javascript
const div = (a, b) => {
 return a / b; 
}
```

We had the following testing code: 

```javascript
const ops = require('../operations')
const assert = require('assert');

describe('wg', function () {
    it('should return valid result', function () {
      assert.equal(ops.add(3, 4), 7)
    });
     describe('division tests', function() {
       it('Should return valid division'), function() {
        assert.equal(ops.div(5, 2), 2.5)
        })
     })
  });
```

Instead of adding the logic to the div function and testing with console.log:

1. Let's first write the test that verifies division by 0: 


```javascript
const ops = require('../operations')
const assert = require('assert');

describe('wg', function () {
    it('should return valid result', function () {
      assert.equal(ops.add(3, 4), 7)
    });
     describe('division tests', function() {
       it('Should return valid division'), function() {
        assert.equal(ops.div(5, 2), 2.5)
        })

       it('Should return -1 when the division fails'), function() {
        assert.equal(ops.div(5, 0), -1)
        })

     })
  });

```


2. We launch the test and verify that it fails (`mocha`) 
3. We modify the code of the div function so that it does not fail the test 

4. We relaunch the test

## Methodology advantages
- BUG FIX: Through this approach, we are better able to handle bugs and control them in a systematic way. We have to reason about all the anomalous conditions in our software and fix them
- BUG REGRESSION: Sometimes modifying code results in regression bugs, that is, bugs that were not present before. Using tests, we can know if a modification is changing the logic to such an extent that it breaks tests, and thus detect regression bugs right away. 
- MODULARITY AND REUSABILITY: We are forced to think in terms of modularity and reusability since our code used for testing must accept an input, and return an output
- SEPARATION OF RESPONSIBILITIES: We keep business logic separate from the logic of interaction with external components. In this way we can keep the functions of external interactions fixed and modify only the modules that need to change the input by adding new test cases and new input data
- SELF-DOCUMENTED CODE: By reading the tests we easily understand what the functions do. An input corresponds to an output. So many times the best documentation for a code is the tests.


## Write testing code
To follow the methodology, we are forced to write MODULAR code. 

Each function dedicated to Unit Testing must have the following characteristics: 

### Must not contain interactions with external sources

The modules used for testing must not interact with external file-system entities or socket networks, or databases. It must simply accept an input, modify it, and return an output. Examples

function that finds a substring in a test

function that returns a subnet from a data structure

function that searches or filters an object in a set of objects 

This principle is fundamental, as it allows logic to be kept separate from interactions with external components. 

### In tests, data that should be taken from external interactions are written as variables or test files
How do I do if my input comes from a file or HTTP request? In my code I will have a module that interacts with the file-system or networking. this module I can also test it, but NOT with UNIT TESTING, in this case it is better to take a “classic” approach, i.e. do tests with sample code, do FUNCTIONAL TESTING and INTEGRATION TESTING, no UNIT TESTING. 

Although there are external interactions, eventually I have to transform the input somewhere. The trick is to separate the logic of transforming the input from the logic of interacting with the external world. 

 So I will have two modules: 

- One that interacts with external servers via HTTP requests. 
- Another one that has to do the parsing


```javascript
code/
  network.js // code that makes external requests to the database and uses the parser to modify them 
  parser.js // code that contains only HTTP page modification logic
  test/parser_test.js // testing code for the parser, I can use sample data because I decoupled HTTP interactions from data modification logic
```

The second module CAN easily be used for testing.  Just don't mix the acquisition logic from the network with the module's parsing logic.

The parsing module will accept as input a string containing the “body” of the HTTP request: 

```javascript
const parsePage = (body) => {
   ...
} 
```

But how do we test it without making the request first? Very simple, we save it the contents of an HTTP request to a file inside the test folder: 

```javascript
cat test_page.txt  

<!doctype html>
<html lang="it">
<head>
    <meta http-equiv="Content-Type" content="text/html" charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name='ir-site-verification-token' value='-2046489346'>

    <link href="https://www.spaziogames.it/wp-content/themes/tomshw/css/fonts/fonts.css" rel="stylesheet">
        <link rel="apple-touch-icon" sizes="180x180" href="/wp-content/themes/tomshw/assets/favicon/apple-touch-icon.png">
    <link rel="icon" type="image/png" sizes="32x32" href="/wp-content/themes/tomshw/assets/favicon/favicon-32x32.png">
    <link rel="icon" type="image/png" sizes="16x16" href="/wp-content/themes/tomshw/assets/favicon/favicon-16x16.png">
    <link rel="manifest" href="/wp-content/themes/tomshw/assets/favicon/site.webmanifest">
    <link rel="mask-icon" href="/wp-content/themes/tomshw/assets/favicon/safari-pinned-tab.svg" color="#5bbad5">
    <link rel="shortcut icon" href="/wp-content/themes/tomshw/assets/favicon/favicon.ico">
    <meta name="msapplication-TileColor" content="#da532c">
    <meta name="msapplication-config" content="/wp-content/themes/tomshw/assets/favicon/browserconfig.xml">
    <meta name="theme-color" content="#222222">

    <script>function fvmuag(){if(navigator.userAgent.match(/x11.*fox\/54|oid\s4.*xus.*ome\/62|oobot|ighth|tmetr|eadles|ingdo/i))return!1;if(navigator.userAgent.match(/x11.*ome\/75\.0\.3770\.100/i)){var e=screen.width,t=screen.height;if("number"==typeof e&&"number"==typeof t&&862==t&&1367==e)return!1}return!0}</script><script>function loadAsync(e,a){var t=document.createElement("script");t.src=e,null!==a&&(t.readyState?t.onreadystatechange=function(){"loaded"!=t.readyState&&"complete"!=t.readyState||(t.onreadystatechange=null,a())}:t.onload=function(){a()}),document.getElementsByTagName("head")[0].appendChild(t)}</script>
	<!-- This site is optimized with the Yoast SEO plugin v14.7 - https://yoast.com/wordpress/plugins/seo/ -->
	<title>Videogiochi per PC e Console - SpazioGames.it</title>
	<meta name="description" content="Tutto sul mondo dei videogiochi. Troverai tantissime anteprime, recensioni, notizie dei giochi per tutte le console, PC, iPhone e Android." />
	<meta name="robots" content="index, follow" />
	<meta name="googlebot" content="index, follow, max-snippet:-1, max-image-preview:large, max-video-preview:-1" />
	<meta name="bingbot" content="index, follow, max-snippet:-1, max-image-preview:large, max-video-preview:-1" />
	<link rel="canonical" href="https://www.spaziogames.it/" />
	<meta property="og:locale" content="it_IT" />
	<meta property="og:type" content="website" />
	<meta property="og:title" content="Videogiochi per PC e Console - SpazioGames.it" />
	<meta property="og:description" content="Tutto sul mondo dei videogiochi. Troverai tantissime anteprime, recensioni, notizie dei giochi per tutte le console, PC, iPhone e Android." />
	<meta property="og:url" content="https://www.spaziogames.it/" />
	<meta property="og:site_name" content="SpazioGames" />
	<meta property="article:publisher" content="https://www.facebook.com/Spaziogames/" />
	<meta property="article:modified_time" content="2020-08-12T04:27:39+00:00" />
	<meta property="og:image" content="https://www.spaziogames.it/wp-content/uploads/2018/09/Senza-titolo-1.jpg" />
	<meta property="og:image:width" content="1280" />
	<meta property="og:image:height" content="720" />
	<meta name="twitter:card" content="summary_large_image" />
	<meta name="twitter:creator" content="@spaziogames" />
	<meta name="twitter:site" content="@spaziogames" />
	<script type="application/ld+json" class="yoast-schema-graph">{"@context":"https://schema.org","@graph":[{"@type":"WebSite","@id":"https://www.spaziogames.it/#website","url":"https://www.spaziogames.it/","name":"SpazioGames","description":"Videogiochi e Videogames per PC, PS4, XONE, SWITCH, 3DS","potentialAction":[{"@type":"SearchAction","target":"https://www.spaziogames.it/?s={search_term_string}","query-input":"required name=search_term_string"}],"inLanguage":"it-IT"},{"@type":"ImageObject","@id":"https://www.spaziogames.it/#primaryimage","inLanguage":"it-IT","url":"https://www.spaziogames.it/wp-content/uploads/2018/09/Senza-titolo-1.jpg","width":1280,"height":720,"caption":"Spaziogames si Rinnova"},{"@type":"WebPage","@id":"https://www.spaziogames.it/#webpage","url":"https://www.spaziogames.it/","name":"Videogiochi per PC e Console - SpazioGames.it","isPartOf":{"@id":"https://www.spaziogames.it/#website"},"primaryImageOfPage":{"@id":"https://www.spaziogames.it/#primaryimage"},"datePublished":"2018-08-02T13:11:13+00:00","dateModified":"2020-08-12T04:27:39+00:00","description":"Tutto sul mondo dei videogiochi. Troverai tantissime anteprime, recensioni, notizie dei giochi per tutte le console, PC, iPhone e Android.","inLanguage":"it-IT","potentialAction":[{"@type":"ReadAction","target":["https://www.spaziogames.it/"]}]}]}</script>
	<!-- / Yoast SEO plugin. -->
...
```

Or with a variable:
```javascript
const pageTest = `

<!doctype html>
<html lang="it">
<head>
    <meta http-equiv="Content-Type" content="text/html" charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name='ir-site-verification-token' value='-2046489346'>

    <link href="https://www.spaziogames.it/wp-content/themes/tomshw/css/fonts/fonts.css" rel="stylesheet">
        <link rel="apple-touch-icon" sizes="180x180" href="/wp-content/themes/tomshw/assets/favicon/apple-touch-icon.png">
    <link rel="icon" type="image/png" sizes="32x32" href="/wp-content/themes/tomshw/assets/favicon/favicon-32x32.png">
    <link rel="icon" type="image/png" sizes="16x16" href="/wp-content/themes/tomshw/assets/favicon/favicon-16x16.png">
    <link rel="manifest" href="/wp-content/themes/tomshw/assets/favicon/site.webmanifest">
    <link rel="mask-icon" href="/wp-content/themes/tomshw/assets/favicon/safari-pinned-tab.svg" color="#5bbad5">
    <link rel="shortcut icon" href="/wp-content/themes/tomshw/assets/favicon/favicon.ico">
    <meta name="msapplication-TileColor" content="#da532c">
    <meta name="msapplication-config" content="/wp-content/themes/tomshw/assets/favicon/browserconfig.xml">
    <meta name="theme-color" content="#222222">

    <script>function fvmuag(){if(navigator.userAgent.match(/x11.*fox\/54|oid\s4.*xus.*ome\/62|oobot|ighth|tmetr|eadles|ingdo/i))return!1;if(navigator.userAgent.match(/x11.*ome\/75\.0\.3770\.100/i)){var e=screen.width,t=screen.height;if("number"==typeof e&&"number"==typeof t&&862==t&&1367==e)return!1}return!0}</script><script>function loadAsync(e,a){var t=document.createElement("script");t.src=e,null!==a&&(t.readyState?t.onreadystatechange=function(){"loaded"!=t.readyState&&"complete"!=t.readyState||(t.onreadystatechange=null,a())}:t.onload=function(){a()}),document.getElementsByTagName("head")[0].appendChild(t)}</script>
	<!-- This site is optimized with the Yoast SEO plugin v14.7 - https://yoast.com/wordpress/plugins/seo/ -->
	<title>Videogiochi per PC e Console - SpazioGames.it</title>
	<meta name="description" content="Tutto sul mondo dei videogiochi. Troverai tantissime anteprime, recensioni, notizie dei giochi per tutte le console, PC, iPhone e Android." />
	<meta name="robots" content="index, follow" />
	<meta name="googlebot" content="index, follow, max-snippet:-1, max-image-preview:large, max-video-preview:-1" />
	<meta name="bingbot" content="index, follow, max-snippet:-1, max-image-preview:large, max-video-preview:-1" />
	<link rel="canonical" href="https://www.spaziogames.it/" />
	<meta property="og:locale" content="it_IT" />
	<meta property="og:type" content="website" />
	<meta property="og:title" content="Videogiochi per PC e Console - SpazioGames.it" />
	<meta property="og:description" content="Tutto sul mondo dei videogiochi. Troverai tantissime anteprime, recensioni, notizie dei giochi per tutte le console, PC, iPhone e Android." />
	<meta property="og:url" content="https://www.spaziogames.it/" />
	<meta property="og:site_name" content="SpazioGames" />
	<meta property="article:publisher" content="https://www.facebook.com/Spaziogames/" />
	<meta property="article:modified_time" content="2020-08-12T04:27:39+00:00" />
	<meta property="og:image" content="https://www.spaziogames.it/wp-content/uploads/2018/09/Senza-titolo-1.jpg" />
	<meta property="og:image:width" content="1280" />
	<meta property="og:image:height" content="720" />
	<meta name="twitter:card" content="summary_large_image" />
	<meta name="twitter:creator" content="@spaziogames" />
	<meta name="twitter:site" content="@spaziogames" />
	<script type="application/ld+json" class="yoast-schema-graph">{"@context":"https://schema.org","@graph":[{"@type":"WebSite","@id":"https://www.spaziogames.it/#website","url":"https://www.spaziogames.it/","name":"SpazioGames","description":"Videogiochi e Videogames per PC, PS4, XONE, SWITCH, 3DS","potentialAction":[{"@type":"SearchAction","target":"https://www.spaziogames.it/?s={search_term_string}","query-input":"required name=search_term_string"}],"inLanguage":"it-IT"},{"@type":"ImageObject","@id":"https://www.spaziogames.it/#primaryimage","inLanguage":"it-IT","url":"https://www.spaziogames.it/wp-content/uploads/2018/09/Senza-titolo-1.jpg","width":1280,"height":720,"caption":"Spaziogames si Rinnova"},{"@type":"WebPage","@id":"https://www.spaziogames.it/#webpage","url":"https://www.spaziogames.it/","name":"Videogiochi per PC e Console - SpazioGames.it","isPartOf":{"@id":"https://www.spaziogames.it/#website"},"primaryImageOfPage":{"@id":"https://www.spaziogames.it/#primaryimage"},"datePublished":"2018-08-02T13:11:13+00:00","dateModified":"2020-08-12T04:27:39+00:00","description":"Tutto sul mondo dei videogiochi. Troverai tantissime anteprime, recensioni, notizie dei giochi per tutte le console, PC, iPhone e Android.","inLanguage":"it-IT","potentialAction":[{"@type":"ReadAction","target":["https://www.spaziogames.it/"]}]}]}</script>
	<!-- / Yoast SEO plugin. -->


<style type="text/css" media="all">/*!
 * Bootstrap v4.1.1 (https://getbootstrap.com/)
 * Copyright 2011-2018 The Bootstrap Authors
 * Copyright 2011-2018 Twitter, Inc.
 * Licensed under MIT (https://github.com/twbs/bootstrap/blob/master/LICENSE)
 */
`≠
```

At this point our tests can read the file and put it into a variable or use the preconfigured variable, and we can write the parsing logic. 

## In the tests we can also write example data
Still considering the preedent case, let's put the case that we need to find all the links in the page in the parser above. 

In addition to taking “real” examples, we can also easily write an example file (perhaps removing unnecessary stuff from a real example file): 

```javascript
const parser = require('../myparser') 
const assert = require('assert');

const pageTest = `
<html>
<head>
</head>
<body>
<a href="http://google.com"> google </a>
<a href="https://spaziogames.net"> spaziogames </a>
</body>

`

describe('parser-test', function () {
   it("Should return the list of links", () => {
      assert(parser.getLinks(pageTest), ["http://google.com", "https://spaziogames.net"] 
    })
}) 
```

At this point we write implementation logic for the getLinks function until we solve the problem. 

### Why is it effective to separate the external interaction code from the code that modifies input and returns output?


- We don't have to re-launch the Internet connection every time and we optimize the timing of testing

- The web page (and in general interactions with external components) is changeable over time, whereas a string is fixed forever. This way, we are sure that our code does not have a bug for that test case.

- This way we can easily test all the logic that modifies the input and returns an output. We no longer mix external interaction logic with business logic


### Writing INPUT - OUTPUT functions
To test forms, our functions need to do very few things:

- Accept an input
- modify it
- return it 

All the logic of modifying the input is embedded in these modular, testable and reusable functions.
