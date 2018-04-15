var fs = require('fs');
fs.readFile('example-log.txt', function(err, logData) {
    if(err) throw err;
    var text = logData.toString();
    var result = {};
    var lines = text.split('\n');
    lines.forEach(function(line) {
        if(!line) return;

        var parts = line.split(' ');
        var letter = parts[1];
        var count = parseInt(parts[2]);

        if(!result[letter]) {
            result[letter] = 0;
        }
        result[letter] += count;
    });
    console.log(result);
});
