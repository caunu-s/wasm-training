package com.caunus.sampleapp;

import static org.junit.Assert.assertEquals;
import static org.junit.Assume.assumeTrue;

import java.io.IOException;
import java.math.BigInteger;

import com.caunus.sampleapp.Main;
import org.graalvm.polyglot.Context;
import org.junit.Test;

public class SampleAppTest {
	
	@Test
	public void test() throws IOException {
		Main.main(new String[0]);
	}

}
