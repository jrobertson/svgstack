#!/usr/bin/env ruby

# file: svgstack.rb

# description: A 1st attempt at creating a stack using SVG

require 'victor'
require 'dynarex'


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
    
    
    @x, @y, @width, @height = x, y, width, height
    
    @css = "
    rect {
      fill: #f6f;
    }

    text { fill: blue}
"

    if data then
      @boxes = data       
      @doc = render()
    end


  end
  
  def import(s)
    
    s2 = s.slice(/<\?svgstack [^>]*\?>/)

    if s2 then
      
      attributes = %w(delimiter id schema).inject({}) do |r, keyword|
        found = s2[/(?<=#{keyword}=['"])[^'"]+/]
        found ? r.merge(keyword.to_sym => found) : r
      end
      
    end
    
    @dx = Dynarex.new s.sub(/svgstack/, 'dynarex') 
    @boxes = @dx.to_h.to_a.reverse
    @doc = render()

  end
  
  def render()
    
    @height ||= (@boxes.length * 50) + 50    

    @svg = Victor::SVG.new viewBox: [@x, @y, @width, @height].join(' ')
    
    build @boxes
    
  end

  def save(file='untitled')    
    File.write file, @doc
  end
  
  def to_svg()
    @doc
  end

  private
  
  def add_box(label, y)
    
    boxwidth = @width
    
    @svg.rect(x: 0, y: y, width: boxwidth, height: 40)
    @svg.text label, {x: boxwidth / 2, y: y+20, font_family: 'arial', 
              font_weight: 'bold', font_size: 20,  
              :"dominant-baseline" => "middle", :"text-anchor" => "middle"}    
  end

  def build(layers)

    y = 0

    layers.reverse.each do |label, url|

      @svg.g do
        
        if url then
          
          @svg.a(href: url) do 
            add_box(label, y)
          end
          
        else
          add_box(label, y)
        end

      end

      y+=50

    end
    
    #inject the css    
    
    @svg.render.lines.insert(7, css_code()).join

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
