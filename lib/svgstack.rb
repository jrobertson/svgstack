#!/usr/bin/env ruby

# file: svgstack.rb

# description: A 1st attempt at creating a stack using SVG

require 'victor'


module RegGem

  def self.register()
'
hkey_gems
  doctype
    svgstack
      require svgstack
      class SvgStack
      media_type svg
'      
  end
end

class SvgStack
  
  attr_accessor :css

  def initialize(data=nil, x: 0,  y: 0, width: 150, height: nil)

    boxes = data if data.is_a? Array
    
    height ||= (boxes.length * 50) + 50    

    @svg = Victor::SVG.new viewBox: [x, y, width, height].join(' ')
    @boxwidth = width
    build boxes
    
    @css = "
    rect {
      fill: #f6f;
    }

    text { fill: blue}
"

  end

  def save(file='untitled')
    
    @svg.save file
    
    #inject the css    
    
    s = File.read file
    s2 = s.lines.insert 7, css_code()
    File.write file, s2.join
  end

  private

  def build(labels)

    y = 0

    labels.reverse.each do |label|

      @svg.g do
        @svg.rect x: 0, y: y, width: @boxwidth, height: 40
        @svg.text label, {x: @boxwidth / 2, y: y+20, font_family: 'arial', 
                  font_weight: 'bold', font_size: 20,  
                  :"dominant-baseline" => "middle", :"text-anchor" => "middle"}

      end

      y+=50

    end

  end
  
  def css_code()
<<EOF    
	<defs>
		<style type='text/css'><![CDATA[
      #{@css}
		]]></style>
	</defs>    
	
EOF
  end
end
