package nl.vijfhart;

import org.junit.*;

class AppTest {
  @Test
  public void testHello(){
    Assert.assertEquals("Hello Java", MyResource.hello());
  }
}
  
