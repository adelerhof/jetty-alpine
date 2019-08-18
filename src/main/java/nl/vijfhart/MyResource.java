package nl.vijfhart;

import java.util.*;
import javax.ws.rs.*;
import javax.ws.rs.core.*;

@Path("java-webapp")
public class MyResource {
    
    @GET
    @Produces(MediaType.TEXT_PLAIN)
    public static String hello() {
        return "Hello Java";
    }
}
