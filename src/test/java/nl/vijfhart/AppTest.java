package nl.vijfhart;

import org.junit.*;

public class AppTest {
  @Test
  public void testHello(){
    Assert.assertEquals("Hello Java", MyResource.hello());
  }
}
  
