require 'jbundler'
require 'lib/jsonj'
require 'json'

java_import com.github.jsonj.tools.JsonBuilder
java_import com.github.jsonj.JsonObject

describe 'jsonj integration' do
  
  list = [1,2,3,"four",{"five" => 6}]
  dict={'x' => 'str', 'y' => list, 'z'=>true,'n'=>42}
  
  it 'should call dynamically added toRuby function on JsonObject' do
    jo = JsonBuilder.fromObject(dict)
    result = jo.toRuby
    result.should eq dict    
  end
  
  it 'should call dynamically added toRuby function on JsonArray' do
    ja = JsonBuilder.fromObject(list)
    result = ja.toRuby
    result.should eq list    
  end
  
  it 'should call dynamically added function on hash' do    
    jo = JsonBuilder.fromObject(dict)
    converted=dict.toJsonJ
    converted.should eq jo
  end
  
  describe "get using []" do
    it 'should support extracting primitives from objects' do
      dict['x'].should eq 'str'
      dict['z'].should eq true
      dict['n'].should eq 42
    end
    
    it 'shouls support extracting things from lists' do
      dict['y'][2].should eq 3
      dict['y'][3].should eq 'four'
    end
    
    it 'should return nil for non existing elements' do
      dict['idontexist'].should eq nil
    end
  end
  
  describe "put using []" do
    it 'should assign things to objects' do
      o=JsonObject.new
      o['a'] = 42
      o['a'].should eq 42    
    end
    
    it 'should assign things to lists' do
      l=JsonArray.new
      l.add(1)
      l.add(1)
      l.add(1)
      l.add(1)
      l[0]=42
      l[1]=[1,2,3]
      l[2]=[]
      l[3]={:a=>42}
      l.get(0).asInt.should eq 42
      l.get(1).asArray.get(2).asInt.should eq 3
      l.get(2).isEmpty.should eq true
      l.get(3).asObject.getInt("a").should eq 42
    end
    
    it "should add to array" do
      l=JsonArray.new
      l << 42
      l[0].should eq 42
    end    

    it 'should assign nil correctly' do
      o=JsonObject.new
      o['nilelement'] = nil
    end
  end
end
