Package.describe({
  summary: "Facebook Procurer for Exposure Analysis"
});

Package.on_use(function (api, where) {

  api.use("coffeescript","server");
  api.use('procurer-base', 'server');

  api.add_files(['lib/facebook-procurer.coffee'], 'server');
  api.export && api.export('FacebookProcurer', 'server');

});

Package.on_test(function (api) {
});
