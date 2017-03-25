require 'spec_helper'

describe Rhtml do

  it 'has a version number' do
    expect(Rhtml::VERSION).not_to be nil
  end

  describe Rhtml::Block do

    it 'adds tag methods to instance' do
      instance = Rhtml::Block.new
      Rhtml::Block::TAGS.each do |tag|
        expect(instance.respond_to?(tag)).to eq(true)
      end
    end

    it 'generates un-closed HTML tags' do
      Rhtml::Block::TAGS.each do |tag|
        block = Rhtml::Block.new do
          send(tag, { class: 'my-class', id: 'my-id-1234' })
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
      end
      result = "<ul><li class=\"my-class\" id=\"my-id\">This is a test</li><li class=\"your-class\" id=\"another-id\">this is another test</li></ul>"
      expect(output.content).to eq(result)
    end

    it 'generates nested HTML tags with text' do
      output = Rhtml::Block.new do
        p class: 'my-paragraph' do
          text 'my inner text'
        end
      end
      result = "<p class=\"my-paragraph\">my inner text</p>"
      expect(output.content).to eq(result)
    end

  end
end
