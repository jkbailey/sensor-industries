var gulp = require('gulp');
var concat = require('gulp-concat');
var uglify = require('gulp-uglify');
var coffee = require('gulp-coffee');
var order = require('gulp-order');
var gulpif = require('gulp-if');
var eco = require('gulp-eco');
var print = require('gulp-print');
var watch = require('gulp-watch');
var sass = require('gulp-sass');
var bourbon = require('node-bourbon').includePaths;

gulp.task('scripts', function() {
  stream = gulp.src([
      'vendor/**/*.js',
      'src/js/**/*.coffee',
      'src/js/**/*.eco'
    ])
    .pipe(gulpif(/[.]eco$/, eco({basePath: 'src/js'})))
    .pipe(gulpif(/[.]coffee$/, coffee()))
    .pipe(order([
      'vendor/jquery.js',
      'vendor/underscore.js',
      'vendor/backbone.js',
      'vendor/backbone.marionette.js',
      'vendor/**/*.js',

      'src/js/app.js',
      'src/js/**/templates/**/*.js',
      'src/js/**/concerns/**/*.js',
      'src/js/**/utilities/**/*.js',
      'src/js/**/*.js'
    ], {base: '.'}))
    .pipe(print())
    .pipe(concat("app.js"))
    .pipe(gulp.dest('js'));
});

gulp.task('styles', function () {
  return gulp.src([
      './src/css/base.scss'
    ])
    .pipe(sass({
      includePaths: require('node-normalize-scss').with(bourbon, 'src/css')
      // - or -
      // includePaths: require('node-normalize-scss').includePaths
    }).on('error', sass.logError))
    .pipe(gulp.dest('./css'));
});

gulp.task('watch', ['scripts','styles'], function() {
  gulp.watch('src/js/**/*.coffee', ['scripts']);
  gulp.watch('src/js/**/*.eco', ['scripts']);
  gulp.watch('./src/css/**/*.scss', ['styles']);
});

gulp.task('default', ['scripts','styles']);
