module sui_place::place{
    use std::vector;

    struct Place has key, store{
        id: UID,
    }

    struct Quadrant has key, store{
        id: UID,
        quadrant_id: u8,
        board: vector<vector<u32>>,
    }

    fun make_row(length:u64): vector<u32>{
        //init empty vector
        //append length number of #ffffff
        //return vector
    }

    fun make_quadrent_pixels(length: u64): vector<vector<u32>>{
        //init empty vector
        //append result of make_row(400) length number of times
        //return vector
    }

    fun init(ctx: &mut TxContext) {
        //create place object
        // create the 4 quadrants, initialize each pixel grid to white
        // place the 4 quadrants as dynamic fields with quadrant id on place
        //make place shared object
    }

    public fun get_quadrant_id(x:u64, y:u64): u64{
        //return 0,1,2,3 based on x,y
    }

    public fun set_pixel_at( place: &mut Place, x:u64, y:u64, color:u32) {
        // assert that x,y, are in bound (400x400)
        //get the quadrent id based on x & y
        //get quadrent from dinamic field object mapping on place
        //place the pixel in the quadrent
    }

    public fun get_quadrants(place:&mut Place): vector<address>{
        //create an empty vector
        //itrate from 0 to 3
        //lookup quadrent in object mapping from quadrent id
        //push each quadrent id/address to the vector
        //return the vector
    }
}
