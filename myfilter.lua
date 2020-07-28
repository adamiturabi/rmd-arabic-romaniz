function MyTransliterate(text2)
  digraph_en = false

  mylcase = {}
  mylcase["E"] = "ʾ"
  mylcase["A"] = "ā"
  mylcase["v"] = "ṯ"
  mylcase["j"] = "ǧ"
  mylcase["H"] = "ḥ"
  mylcase["p"] = "ḏ"
  mylcase["c"] = "š"
  mylcase["S"] = "ṣ"
  mylcase["D"] = "ḍ"
  mylcase["T"] = "ṭ"
  mylcase["P"] = "ḏ̣"
  mylcase["e"] = "ɛ"
  mylcase["g"] = "ġ"
  mylcase["o"] = "ḧ"
  mylcase["O"] = "ẗ"
  mylcase["I"] = "ī"
  mylcase["U"] = "ū"
  mylcase["="] = "·"
  myucase = {}
  myucase["E"] = "ʾ"
  myucase["A"] = "Ā"
  myucase["v"] = "Ṯ"
  myucase["j"] = "Ǧ"
  myucase["H"] = "Ḥ"
  myucase["x"] = "X"
  myucase["p"] = "Ḏ"
  myucase["c"] = "Š"
  myucase["S"] = "Ṣ"
  myucase["D"] = "Ḍ"
  myucase["T"] = "Ṭ"
  myucase["P"] = "Ḏ̣"
  myucase["e"] = "Ɛ"
  myucase["g"] = "Ġ"
  myucase["I"] = "Ī"
  myucase["U"] = "Ū"
  myucase["a"] = "A"
  myucase["i"] = "I"
  myucase["u"] = "U"
  myucase["b"] = "B"
  myucase["t"] = "T"
  myucase["d"] = "D"
  myucase["r"] = "R"
  myucase["z"] = "Z"
  myucase["s"] = "S"
  myucase["f"] = "F"
  myucase["q"] = "Q"
  myucase["k"] = "K"
  myucase["l"] = "L"
  myucase["m"] = "M"
  myucase["n"] = "N"
  myucase["h"] = "H"
  myucase["w"] = "W"
  myucase["y"] = "Y"

  if digraph_en then
    mylcase["v"] = "th"
    myucase["v"] = "Th"
    mylcase["c"] = "sh"
    myucase["c"] = "Sh"
    mylcase["x"] = "kh"
    myucase["x"] = "Kh"
    mylcase["g"] = "gh"
    myucase["g"] = "Gh"
  end

  text3 = ''
  local caps = false
  local prev_charv = ''
  for index3 = 1, #text2 do
    local charv = text2:sub(index3, index3)
    if charv == "#" then
      caps = true
    else
      if caps then
        if myucase[charv] == nil then
          text3 = text3 .. charv
        else
          text3 = text3 .. myucase[charv]
        end
        caps = false
      else
        if digraph_en and charv == 'h' and prev_charv ~= '=' and (prev_charv == 't' or prev_charv == 's' or prev_charv == 'k' or prev_charv == 'd' or prev_charv == 'p' or prev_charv == 'P' or prev_charv == 'D' or prev_charv == 'c' or prev_charv == 'v' or prev_charv == 'x' or prev_charv == 'g') then
          text3 = text3 .. "·"
        end
        if mylcase[charv] == nil then
          text3 = text3 .. charv
        else
          text3 = text3 .. mylcase[charv]
        end
      end
    end
    prev_charv = charv
  end
  return text3
end
function Span (elem)
  if elem.classes[1] == 'trn' then
    for index,text in pairs(elem.content) do
      for index2,text2 in pairs(text) do
        text3 = MyTransliterate(text2)
	      text[index2] = text3
      end
      elem.content[index] = text
    end
    return pandoc.Emph (elem.content)
  elseif elem.classes[1] == 'trn2' then
    for index,text in pairs(elem.content) do
      for index2,text2 in pairs(text) do
        text3 = MyTransliterate(text2)
	      text[index2] = text3
      end
      elem.content[index] = text
    end
    return (elem.content)
  elseif elem.classes[1] == 'ar' then
    attrs = pandoc.Attr("", {}, {{"lang", "ar"},{"dir","rtl"}})
    return pandoc.Span(elem.content, attrs)
  else
    return elem
  end
end
