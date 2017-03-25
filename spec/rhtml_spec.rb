require 'spec_helper'

describe Rhtml do

  it 'has a version number' do
    expect(Rhtml::VERSION).not_to be nil
  end

  describe Rhtml::Block do

    it 'generates un-closed HTML tags' do
      Rhtml::Block::TAGS.each do |tag|
        block = Rhtml::Block.new do
          send(tag, { class: 'my-class', id: 'my-id-1234'})
        end
        result = "<#{tag} class=\"my-class\" id=\"my-id-1234\">"
        expect(block.content).to eq(result)
      end
    end

    it 'generates closed HTML tags' do
      Rhtml::Block::TAGS.each do |tag|
        block = Rhtml::Block.new do
          send(tag, 'some content within a tag', { class: 'my-class', id: 'my-id-1234'})
        end
        result = "<#{tag} class=\"my-class\" id=\"my-id-1234\">some content within a tag</#{tag}>"
        expect(block.content).to eq(result)
      end
    end

    it 'generates nested HTML tags' do
      output = Rhtml::Block.new do
        ul do
          li 'This is a test', class: 'my-class', id: 'my-id'
          li 'this is another test', class: 'your-class', id: 'another-id'
        end
        p class: 'my-paragraph' do
          span 'my inner span text'
        end
      end
      result = "<ul><li class=\"my-class\" id=\"my-id\">This is a test</li><li class=\"your-class\" id=\"another-id\">this is another test</li></ul><p class=\"my-paragraph\"><span>my inner span text</span></p>"
      expect(output.content).to eq(result)
    end

  end
end
