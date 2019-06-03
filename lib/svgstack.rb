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

  def initialize(data=nil, x: 0,  y: 0, width: 700, height: 70)

    boxes = data if data.is_a? Array

    @svg = Victor::SVG.new viewBox: [x, y, width, height].join(' ')
    build boxes

  end

  def save(file='untitled')
    @svg.save file
  end

  private

  def build(labels)

    y = 0

    labels.each do |label|

      @svg.g do
        @svg.rect x: 50, y: y, width: 100, height: 40, fill: '#362'
        @svg.text label, x: 60, y: y+20, font_family: 'arial', 
                  font_weight: 'bold', font_size: 20, fill: 'blue'
      end

      y+=50

    end

  end

end
