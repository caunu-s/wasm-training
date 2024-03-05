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
                for (int i = 0; i < 100; i++) {
                    Source source = Source.newBuilder("wasm", Main.class.getResource("sigma.wasm")).build();
                    context.eval(source);
                    Value sigma = context.getBindings("wasm").getMember("main").getMember("sigma");
                    System.out.println("wasm: sigma(300) = " + sigma.execute(300L));
                    source = null;
                    sigma = null;

                    // Source source = Source.newBuilder("wasm", Main.class.getResource("subLoop.wasm")).build();
                    // context.eval(source);
                    // Value subLoop = context.getBindings("wasm").getMember("main").getMember("subLoop");
                    // System.out.println("wasm: subLoop(500) = " + subLoop.execute(500L));
                    // source = null;
                    // subLoop = null;
                }
            }
        }
    }
}