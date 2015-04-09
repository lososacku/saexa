Package.describe({
  summary: "Tumblr Procurer for Exposure Analysis"
});

Package.on_use(function (api, where) {

  api.use("coffeescript","server");
  api.use('procurer-base', 'server');
  api.use('oauth1', 'server');

  api.add_files(['lib/tumblr-procurer.coffee'], 'server');
  api.export && api.export('TumblrProcurer', 'server');

});

Package.on_test(function (api) {
});
