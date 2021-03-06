// Karma configuration

// base path, that will be used to resolve files and exclude
basePath = '';

// list of files / patterns to load in the browser
files = [
  JASMINE,
  JASMINE_ADAPTER,
  'vendor/assets/components/angular/angular.js',
  'vendor/assets/components/angular-resource/angular-resource.js',
  'vendor/assets/components/angular-mocks/angular-mocks.js',
  'vendor/assets/components/underscore/underscore.js',
  'app/assets/javascripts/*.coffee',
  'app/assets/javascripts/**/*.coffee',
  'test/angular/mock/**/*.coffee',
  'test/angular/spec/**/*.coffee',
  // this line directs Karma to watch these files for changes
  {pattern: 'app/**/*', included: false, served: false},
];

preprocessors = {
  '**/*.coffee': 'coffee',
};

// list of files to exclude
exclude = [];

// test results reporter to use
// possible values: dots || progress || growl
reporters = ['progress', 'growl'];

// web server port
port = 8080;

// cli runner port
runnerPort = 9100;

// enable / disable colors in the output (reporters and logs)
colors = true;

// level of logging
// possible values: LOG_DISABLE || LOG_ERROR || LOG_WARN || LOG_INFO || LOG_DEBUG
logLevel = LOG_INFO;

// enable / disable watching file and executing tests whenever any file changes
autoWatch = true;

// Start these browsers, currently available:
// - Chrome
// - ChromeCanary
// - Firefox
// - Opera
// - Safari (only Mac)
// - PhantomJS
// - IE (only Windows)
browsers = ['ChromeCanary'];

// If browser does not capture in given timeout [ms], kill it
captureTimeout = 5000;

// Continuous Integration mode
// if true, it capture browsers, run tests and exit
singleRun = false;
