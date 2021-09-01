function fn() {
  var env = karate.env;
  var respThreshold = 300;
  var threads = karate.properties['karate.threads'];
  var apiMetaData = read('classpath:apiTest/common/apiMetaData/dev/apiDetails.json')

  if (!env) {
    env = 'dev';
  }

   threads = karate.properties['karate.threads'];
   apiMetaData = read('classpath:apiTest/common/apiMetaData/'+ env + '/apiDetails.json')

   karate.log('karate.env system property was:', env);
   karate.log('karate.threads system property was:', threads);

  var config = {
    env: env,
    apiMetaData: apiMetaData,
    respThreshold: respThreshold
  }

  return config;
}