using System.IO;
using System.Xml;

XmlDocument doc = new XmlDocument();

// write data
XmlElement root = doc.CreateElement("name");
doc.AppendChild(root);

root.SetAttribute("attrib", "attrib-value");

XmlElement child = root.CreateElement("child");
root.AppendChild(child);

child.SetAttribute("child-attrib", "child-attrib-value");

doc.Save(filePath + fileName);

// read data
doc.LoadXml("<root attrib=\"value\"><child attrib=\"value\"/></root>"); or doc.Load(new StreamReader(filePath + fileName));

XmlElement root = doc.DocumentElement;
root.GetAttribute("attrib");//"value"

XmlElement child = (XmlElement)root.FirstChild;
if (child.HasAttribute("attrib"))
    child.GetAttribute("attrib");//"value"
    
XmlElement nextChild = (XmlElement)child.NextSibling;
if (nextChild.HasAttribute("attrib"))
    Int.Parse(child.InnerText);