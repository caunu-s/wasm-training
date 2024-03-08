#!/bin/sh

echo $1

if [ $1 = "wasm" ]; then

    # time
    /usr/bin/time -f "---------- \nreal_time %es\nuser_time %Us \nsys_time  %Ss \nmemory_max %MKB \ncpu %P" \
    java -cp \
    ./target/wasm-graal-training-1.0-SNAPSHOT.jar:\
    $HOME/.m2/repository/org/graalvm/polyglot/polyglot/23.1.2/polyglot-23.1.2.jar:\
    $HOME/.m2/repository/org/graalvm/sdk/collections/23.1.2/collections-23.1.2.jar:\
    $HOME/.m2/repository/org/graalvm/sdk/nativeimage/23.1.2/nativeimage-23.1.2.jar:\
    $HOME/.m2/repository/org/graalvm/sdk/word/23.1.2/word-23.1.2.jar:\
    $HOME/.m2/repository/org/graalvm/wasm/wasm-language/23.1.2/wasm-language-23.1.2.jar:\
    $HOME/.m2/repository/org/graalvm/truffle/truffle-api/23.1.2/truffle-api-23.1.2.jar:\
    $HOME/.m2/repository/org/graalvm/truffle/truffle-runtime/23.1.2/truffle-runtime-23.1.2.jar:\
    $HOME/.m2/repository/org/graalvm/truffle/truffle-enterprise/23.1.2/truffle-enterprise-23.1.2.jar:\
    $HOME/.m2/repository/org/graalvm/truffle/truffle-compiler/23.1.2/truffle-compiler-23.1.2.jar:\
    $HOME/.m2/repository/org/graalvm/sdk/jniutils/23.1.2/jniutils-23.1.2.jar:\
    $HOME/.m2/repository/org/graalvm/sdk/nativebridge/23.1.2/nativebridge-23.1.2.jar:\
    $HOME/.m2/repository/junit/junit/4.13.2/junit-4.13.2.jar:\
    $HOME/.m2/repository/org/hamcrest/hamcrest-core/1.3/hamcrest-core-1.3.jar \
    com.caunus.sampleapp.Main &

    # jstat per 0.1s
    pn=`jps | grep "Main" | sed -e "s/^\(.*\)Main/\1/"`
    ## (C)Current, (U)Use
    jstat -gc -t ${pn} 100 > ./target/jstat-uc.txt &
    ## Heap NGC + OGC
    jstat -gccapacity -t ${pn} 100 > ./target/jstat-gc.txt &

elif [ $1 = "java" ]; then

    # time
    /usr/bin/time -f "---------- \nreal_time %es\nuser_time %Us \nsys_time  %Ss \nmemory_max %MKB \ncpu %P" \
    java -cp \
    ./target/wasm-graal-training-1.0-SNAPSHOT.jar:\
    com.caunus.sampleapp.Addition &

    # jstat per 0.1s
    pn=`jps | grep "Addition" | sed -e "s/^\(.*\)Addition/\1/"`
    ## (C)Current, (U)Use
    jstat -gc -t ${pn} 100 > ./target/jstat-uc.txt &
    ## Heap NGC + OGC
    jstat -gccapacity -t ${pn} 100 > ./target/jstat-gc.txt &

fi

# top 30 times per 0.1s 
top -b -H -n 30 -d 0.1 > ./target/top.txt &
