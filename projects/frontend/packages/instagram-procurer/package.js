Package.describe({
  summary: "Instagram Procurer for Exposure Analysis"
});

Package.on_use(function (api, where) {

  api.use("coffeescript","server");
  api.use('procurer-base', 'server');
  api.use('mrt:accounts-instagram-6', 'server');

  api.add_files(['lib/instagram-procurer.coffee'], 'server');
  api.export && api.export('InstagramProcurer', 'server');

});

Package.on_test(function (api) {
});
