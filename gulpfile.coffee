gulp = require "gulp"
gutil = require "gulp-util"
gulpif  = require "gulp-if"
clean = require "gulp-clean"

uglify = require "gulp-uglify"
coffee = require "gulp-coffee"
eco = require "gulp-eco"

minifyCSS = require "gulp-minify-css"
compass = require "gulp-compass"
sass = require "gulp-ruby-sass"

gzip = require "gulp-gzip"

concat = require "gulp-concat"

include = require "gulp-include"

isRelease = gutil.env.release?

gulp.task "coffee", ["eco"], ->
  gulp.src("assets/**/application.coffee")
    .pipe(include(extensions: ["js", "coffee", "eco"]))
    .pipe(coffee({ bare: true }))
    .pipe(gulpif(isRelease, uglify()))
    .pipe(gulp.dest("./public"))
    .pipe(gzip())
    .pipe(gulp.dest("./public"))


gulp.task "scss", ->
  gulp.src("assets/**/application.scss")
    .pipe(compass(
      sass: "assets/stylesheets"
      css: "public/stylesheets"
    ))
    .pipe(gulpif(isRelease, minifyCSS()))
    .pipe(gulp.dest("./public"))
    .pipe(gzip())
    .pipe(gulp.dest("./public"))


gulp.task "eco", ->
  gulp.src("assets/**/*.eco")
    .pipe(eco())
    .pipe(gulpif(isRelease, uglify()))
    .pipe(gulp.dest("./assets/javascripts"))

gulp.task "watch", ->
  gulp.watch("src/**/*.coffee", ["coffee"])
  gulp.watch("src/**/*.scss", ["scss"])
  gulp.watch("src/**/*.eco", ["coffee"])


gulp.task "clean", ->
  gulp.src "public/assets/**/*.*", {read:false}
    .pipe(clean())


gulp.task("default", ["coffee", "scss", "eco", "watch"])