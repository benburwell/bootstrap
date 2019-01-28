def red_component(color):
  return int(color[1:3], 16)/255

def green_component(color):
  return int(color[3:5], 16)/255

def blue_component(color):
  return int(color[5:7], 16)/255

def css_to_hex(color):
    return "0x" + color[1:]

class FilterModule(object):
  def filters(self):
    return {
      'red_component': red_component,
      'green_component': green_component,
      'blue_component': blue_component,
      'css_to_hex': css_to_hex
    }
