'use strict';

var fs = require('fs'),
  path = require('path'),
  File = require('vinyl'),
  vfs = require('vinyl-fs'),
  concat = require('concat-stream'),
  Handlebars = require('handlebars'),
  autolink = require('./lib/autolink'),
  mapnik = require('child_process'),
  formatMarkdown = require('./lib/format_markdown'),
  formatParameters = require('./lib/format_parameters');

module.exports = function (comments, options, callback) {
  var pageTemplate = Handlebars.compile(fs.readFileSync(path.join(__dirname, 'index.hbs'), 'utf8'));

  Handlebars.registerPartial('section',
    Handlebars.compile(fs.readFileSync(path.join(__dirname, 'section.hbs'), 'utf8'), {
      preventIndent: true
    })
  );

  var paths = comments.map(function (comment) {
    return comment.path.join('.');
  }).filter(function (path) {
    return path;
  });

  // builds a proper blob URI to point to the source code
  // NODE_MAPNIK_GITSHA is provided from /scripts/generate.sh
  Handlebars.registerHelper('mapnik_gitsha', function(url) {
    var base = 'https://github.com/mapnik/node-mapnik/blob';
    var gitsha = process.env.NODE_MAPNIK_GITSHA || 'master';
    var source = url.slice(url.indexOf('src/'));
    return `${base}/${gitsha}/${source}`;
  });

  Handlebars.registerHelper('mapnik_srcpath', function(url) {
    return url.slice(url.indexOf('/src/'));
  });

  Handlebars.registerHelper('permalink', function(url) {
    return url;
  });

  Handlebars.registerHelper('permalink', function () {
    return this.path.join('.');
  });

  Handlebars.registerHelper('autolink', function (text) {
    return new Handlebars.SafeString(autolink(paths, text));
  });

  Handlebars.registerHelper('format_params', formatParameters);

  Handlebars.registerHelper('md', function (string) {
    return new Handlebars.SafeString(formatMarkdown(string, paths));
  });

  Handlebars.registerHelper('format_type', function (type) {
    return new Handlebars.SafeString(formatMarkdown.type(type, paths));
  });

  Handlebars.registerHelper('trunk', function (string) {
    return string.substr(0, 100) + ' ...';
  });

  var highlight = require('./lib/highlight')(options.hljs || {});
  Handlebars.registerHelper('highlight', function (string) {
    return new Handlebars.SafeString(highlight(string));
  });

  // push assets into the pipeline as well.
  vfs.src([__dirname + '/assets/**'], { base: __dirname })
    .pipe(concat(function (files) {
      callback(null, files.concat(new File({
        path: 'index.html',
        contents: new Buffer(pageTemplate({
          docs: comments,
          options: options
        }), 'utf8')
      })));
    }));
};
