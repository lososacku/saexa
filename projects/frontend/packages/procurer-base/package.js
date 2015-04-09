Package.describe({
    summary: "Base Procurer for Exposure Analysis"
});

Package.on_use(function (api, where) {

    api.use("coffeescript","server");

    api.export && api.export('ProcurerBase', 'server');

    api.add_files(['lib/procurer-base.coffee'], 'server');
});

Package.on_test(function (api) {
});
