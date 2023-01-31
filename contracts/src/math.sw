library math; 

// omptimize this, currently just using binary search
// this gets the ceiling 
pub fn sqrt_floor(x: u64) -> u64 {
    let mut min = 1;
    let mut max = x / 2;
    let mut res = 0;
    while min < max {
        let mid = (min + max) / 2;
        let sqr = mid * mid;
        if sqr == x {
            return mid;
        }
        if sqr < x {
           min = mid + 1;

            res = mid;
        } else {
            max = mid - 1;
        }
    }
    return res;
}

pub fn sqrt_ceil(x: u64) -> u64 {
    let mut min = 1;
    let mut max = x / 2;
    let mut res = 0;
    while min <= max {
        let mid = (min + max) / 2;
        let sqr = mid * mid;
        if sqr == x {
            return mid;
        }
        if sqr < x {
           min = mid + 1;
        } else {
            max = mid - 1;
            res = mid;
        }
    }
    return res;
}

#[test]
fn test_sqrt_floor() {
    let seven = sqrt_floor(49);
    assert(seven == 7);
    let seven = sqrt_floor(50);
    assert(seven == 7);
}
#[test]
fn test_sqrt_ceil() {
    let seven = sqrt_ceil(49);
    assert(seven == 7);
    let seven = sqrt_ceil(48);
    assert(seven == 7);
    let five = sqrt_ceil(25);
    assert(five == 5);
}
