# jsonj-integration

This ruby module is intended to be used with jruby and aims to provide seemless integration of the functionality in my Java based "jsonj":"https://github.com/jillesvangurp/jsonj" project.

Using this is useful on mixed jruby and java projects where some of the Java code uses jsonj; as is the case in Localstream, the company I am the co-founder of. In Localstream we use this extensively in our Sinatra based API layer that needs to parse, validate, and manipulate json objects and then call the Java backend services which accept and return JsonObject instances.

# Using it and running the tests

There's an rspec test, which depends on jbundle, which in turn uses your local maven repository (generally in ~/.m2). There's a slight complication in that the jsonj jar is not in maven central but in my own private repository, as documented "here":http://www.jillesvangurp.com/2013/02/27/maven-and-my-github-projects/.

Since you will need the jar file in any case for your java project, it is best to set that up first.

After that, you can run 

<pre>
	# install rspec and jbundler
	gem install jbundler rspec
	# tell jbundle to hook up the jar dependencies
	jbundle install
	# run the tests
	rspec
</pre>	

Using jsonj after that is pretty easy. The rspec file provides several examples.

# License

This code is licensed under the expat license. See the LICENSE file for details.
        

