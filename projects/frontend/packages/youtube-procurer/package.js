Package.describe({
  summary: "Youtube Procurer for Exposure Analysis"
});

Package.on_use(function (api, where) {

  api.use("coffeescript","server");
  api.use('procurer-base', 'server');

  api.add_files(['lib/youtube-procurer.coffee'], 'server');
  api.export && api.export('YoutubeProcurer', 'server');

});

Package.on_test(function (api) {
});
