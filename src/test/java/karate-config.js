function fn() {
  var env = karate.env; // get system property 'karate.env'
  karate.log('karate.env system property was:', env);
  if (!env) {
    env = 'dev';
  }
  var config = {
    apiUrl: 'https://conduit-api.bondaracademy.com/api/',
    //logLevel: 'debug'
  }
  if (env == 'dev') {
    config.userEmail = 'karate@dsl.com'
    config.userPassword = 'karate123'
    // customize
    // e.g. config.foo = 'bar';
  }  if (env == 'qa') {
    // customize
    config.userEmail = 'karate2@dsl.com'
    config.userPassword = 'karate456'
  }
  return config;
}