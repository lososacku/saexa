Package.describe({
  summary: "Twitter Procurer for Exposure Analysis"
});

Package.on_use(function (api, where) {

  api.use("coffeescript","server");
  api.use('procurer-base', 'server');
  api.use('oauth1', 'server');

  api.add_files(['lib/twitter-procurer.coffee'], 'server');
  api.export && api.export('TwitterProcurer', 'server');

});

Package.on_test(function (api) {
});
