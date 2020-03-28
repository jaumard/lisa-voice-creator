const LISA = require('lisa-standalone-voice-command')

const lisa = new LISA({
  matrix: '127.0.0.1',
  speaker: null,
  language: 'fr-FR',
  gSpeech: './speech/LISA-gfile.json'
})

//lisa.trigger(1)
function exitHandler(exit) {
  if (exit) process.exit()
}

//do something when app is closing
process.on('exit', exitHandler.bind(this));

//catches ctrl+c event
process.on('SIGINT', exitHandler.bind(this, true));
