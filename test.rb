def log(msg)
    filename = 'f.log'
    f = File.new(filename, 'a')
    f.puts msg
    puts 'here'
end

def test_log()
    m = 'hhhhhhh'
    log(m)
end

class Song
    attr_reader :name, :artist, :duration
    attr_writer :duration
    @@plays = 0
    def initialize(name, artist, duration)
        @name = name
        @artist = artist
        @duration = duration
        @plays = 0
    end
    def to_s
        "Song: #@name--#@artist (#@duration)"
    end
    def duration_in_minutes
        @duration / 60.0
    end
    def duration_in_minutes=(new_duation)
        @duration = (new_duation * 60).to_i
    end
    def play
        @plays += 1
        @@plays += 1
        "This song: #@plays plays. Total #@@plays plays"
    end
end

class KaraokeSong < Song
    def initialize(name, artist, duration, lyrics)
        super(name, artist, duration)
        @lyrics = lyrics
    end
    def to_s
        super + " [#@lyrics]"
    end
end

def test_song()
    s = Song.new("Bicyclops", "Fleck", 260)
    s.inspect
    s.to_s
    ks = KaraokeSong.new("My way", "Sinatra", 225, "And now, the...")
    ks.to_s
    ks.artist
    ks.name
    ks.duration_in_minutes
    ks.duration_in_minutes = 4.2
    ks.duration_in_minutes
    s1 = Song.new("Song1", "Artist1", 234)
    s2 = Song.new("Song2", "Artist2", 345)
    s1.play
    s2.play
    s1.play
    s1.play
    SongList.is_too_long(s1)
    SongList.is_too_long(s2)
end

class SongList
    MAX_TIME = 5 * 60

    def SongList.is_too_long(song)
        return song.duration > MAX_TIME
    end

    def initialize
        @songs = Array.new
    end

    def append(song)
        @songs.push(song)
        self
    end
    def delete_first
        @songs.shift
    end
    def delete_last
        @songs.pop
    end
    def [](index)
        @songs[index]
    end

    def with_title0(title)
        for i in 0...@songs.length
            return @songs[i] if title == @songs[i].name
        end
        return nil
    end
    def with_title1(title)
        @songs.find {|song| title == song.name}
    end
end

def test_song_list
    list = SongList.new
    s1 = Song.new("Song1", "Artist1", 1)
    s2 = Song.new("Song2", "Artist2", 2)
    s3 = Song.new("Song3", "Artist3", 3)
    s4 = Song.new("Song4", "Artist4", 4)

    list.append(s1).append(s2).append(s3).append(s4)

    list.with_title0('Song1')
    list.with_title1('Song1')
end



class TestSongList < Test::Unit::TestCase
    def TestSongList.test_delete
        list = SongList.new
        s1 = Song.new("Song1", "Artist1", 1)
        s2 = Song.new("Song2", "Artist2", 2)
        s3 = Song.new("Song3", "Artist3", 3)
        s4 = Song.new("Song4", "Artist4", 4)

        list.append(s1).append(s2).append(s3).append(s4)

        assert_equal(s1, list[0])
        assert_equal(s3, list[2])
        assert_nil(list[9])
        assert_equal(s1, list.delete_first)
        assert_equal(s2, list.delete_first)
        assert_equal(s4, list.delete_last)
        assert_equal(s3, list.delete_last)
        assert_nil(list.delete_last)
    end
end



#s1 = Song.new("Song1", "Artist1", 234)
#s2 = Song.new("Song2", "Artist2", 345)
#SongList.is_too_long(s1)
#SongList.is_too_long(s2)

list = SongList.new
s1 = Song.new("Song1", "Artist1", 1)
s2 = Song.new("Song2", "Artist2", 2)
s3 = Song.new("Song3", "Artist3", 3)
s4 = Song.new("Song4", "Artist4", 4)

list.append(s1).append(s2).append(s3).append(s4)

list.with_title0('Song1')
list.with_title1('Song1')

