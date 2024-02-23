package com.caunus.sampleapp;

import org.graalvm.polyglot.Context;
import org.graalvm.polyglot.Source;
import org.graalvm.polyglot.Value;

import java.io.IOException;
import java.nio.file.Files;
import java.util.Set;

public class Main {

    public static void main(String[] args) throws IOException {
        try (Context context = Context.newBuilder().allowAllAccess(true).build()) {
            Set<String> languages = context.getEngine().getLanguages().keySet();
            for (String id : languages) {
                System.out.println("Initializing language " + id);
                context.eval(Source.newBuilder("wasm", Main.class.getResource("sigma.wasm")).build());
                Value factorial = context.getBindings("wasm").getMember("main").getMember("sigma");
                System.out.println("wasm: sigma(10) = " + factorial.execute(10L));
            }
        }
    }
}