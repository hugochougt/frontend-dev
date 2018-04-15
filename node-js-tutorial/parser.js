var fs = require('fs');

var Parser = function() {};
Parser.prototype.parse = function(text) {
    var results = {};
    var lines = text.split('\n');
    lines.forEach(function(line) {
        if(!line) return;

        var parts = line.split(' ');
        var letter = parts[1];
        var count = parseInt(parts[2]);

        if(!results[letter]) {
            results[letter] = 0;
        }
        results[letter] += count;
    });

    return results;
};

module.exports = Parser;
