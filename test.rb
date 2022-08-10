require 'webrick'

server = WEBrick::HTTPServer.new({
  :DocumentRoot => '.',
  :CGIInterpreter => WEBrick::HTTPServlet::CGIHandler::Ruby,
  :Port => '3000',
  })
['INT', 'TERM'].each{|signal|
  Signal.trap(signal){server.shutdown}
}

server.mount('/test', WEBrick::HTTPServlet::ERBHandler, 'test.html.erb')

server.mount('/indicate.cgi', WEBrick::HTTPServlet::CGIHandler, 'indicate.rb')

server.mount('/goya.cgi', WEBrick::HTTPServlet::CGIHandler, 'goya.rb')

server.mount('/exam', WEBrick::HTTPServlet::ERBHandler, 'exam.html.erb')

server.mount('/goya_not.cgi', WEBrick::HTTPServlet::CGIHandler, 'goya_not.rb')

server.mount('/goya_quality.cgi', WEBrick::HTTPServlet::CGIHandler, 'goya_quality.rb')

server.start
