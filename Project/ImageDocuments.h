//---------------------------------------------------------------------------
#ifndef ImageDocumentsH
#define ImageDocumentsH
//---------------------------------------------------------------------------
#include "Project/Document.h"
#include "Graphics/GraphicsTypes.h"
//---------------------------------------------------------------------------
// ImageDocument
// This class encapulates what is an image document.
// It is only used to manage the image content (aka: frames and optionally layers).
// It DOES NOT know the format of the image data; as that is specified by the
// the project machine and graphics mode used.
// All frames are stored in there machine dependent graphic format in hex.
// Basically it is standard bitmap data.
// Only the graphic mode class knows how to encode this information.
//---------------------------------------------------------------------------
class ImageDocument : public Document
{
private:
    typedef std::vector<String>     FramesList;
    typedef std::map<String, String>LayerMap;

            int         __fastcall  CountFrames() const;
            int         __fastcall  CountImagesPerFrame() const;
            void        __fastcall  SetFrames(int frames);
            String      __fastcall  GetFrame(int frame) const;
            void        __fastcall  SetFrame(int frame, const String& data);
            String      __fastcall  GetHint(int frame) const;

protected:
            bool                    m_MultiFrame;       // flag: supports multiple frames
            bool                    m_CanModifyFrames;  // flag: supports adding/deleting frames
            bool                    m_CanBeLocked;      // flag: supports locking the image to a room
            int                     m_Width;            // width of a frame
            int                     m_Height;           // height of a frame
            int                     m_NumOfFrames;      // the number of frames
            int                     m_Index;            // the index of the image in its type list
            ImageTypes              m_ImageType;        // the type of graphic image we are
            FramesList              m_Frames;           // the list of frames
            String                  m_FrameLoader;      // used to load frames into the above frames list
            int                     m_FramesLoaded;     // a count of frames loaded
            FramesList              m_Hints;            // the list of frames
            String                  m_Hint;             // a hint string
            LayerMap                m_Layers;           // the map of layers data
            String                  m_LayerName;        // used to load layers into the above layers list
            String                  m_LayerData;        // used to load layers into the above layers list

    virtual void        __fastcall  OnEndObject(const String& object);
            void        __fastcall  ExtractSize(const String& extra);

            int         __fastcall  GetIndex() const;
            int         __fastcall  GetLayerCount() const;
            void        __fastcall  AddLayer(const String& name, const String& value);
    virtual void        __fastcall  DoSave();
    virtual void        __fastcall  DoSaveExtra();

public:
                        __fastcall  ImageDocument(const String& name);
    static  Document*   __fastcall  Create(const String& name, const String& extra) { return new ImageDocument(name); };

            bool        __fastcall  AddFrame(int index = -1, const String& hint = "");
            bool        __fastcall  DeleteFrame(int index);
            String      __fastcall  GetLayer(const String& name);
            void        __fastcall  SetLayer(const String& name, const String& value);
            bool        __fastcall  LayerExists(const String& name) const;
            bool        __fastcall  IsFirstOfType() const;

            bool        __property  MultiFrame      = { read = m_MultiFrame                 };
            bool        __property  CanModifyFrames = { read = m_CanModifyFrames            };
            bool        __property  CanBeLocked     = { read = m_CanBeLocked                };
            String      __property  Frame[int index]= { read = GetFrame, write = SetFrame   };
            String      __property  Hint[int index] = { read = GetHint                      };
            int         __property  Layers          = { read = GetLayerCount                };
            ImageTypes  __property  ImageType       = { read = m_ImageType                  };

__published:
            int         __property  Width           = { read = m_Width                      };
            int         __property  Height          = { read = m_Height                     };
            int         __property  Frames          = { read = CountFrames                  };
            int         __property  ImagesPerFrame  = { read = CountImagesPerFrame          };
            int         __property  Index           = { read = GetIndex                     };
};
//---------------------------------------------------------------------------
class SpriteDocument : public ImageDocument
{
public:
                        __fastcall  SpriteDocument(const String& name, const String& extra);
    static  Document*   __fastcall  Create(const String& name, const String& extra) { return new SpriteDocument(name, extra); };
};
//---------------------------------------------------------------------------
class ObjectDocument : public ImageDocument
{
private:
    // note: for the IDE property editor to work on there properties, they must be new'd for TPersisent to work
            int                     m_RoomIndex;
            TPoint                  m_Position;
            ObjectState             m_State;

            int         __fastcall  GetPosition(int index);
            void        __fastcall  SetPosition(int value, int index);
            void        __fastcall  SetRoomIndex(int value);

protected:
    virtual void        __fastcall  DoSaveExtra();

public:
                        __fastcall  ObjectDocument(const String& name, const String& extra);
    static  Document*   __fastcall  Create(const String& name, const String& extra) { return new ObjectDocument(name, extra); };

    __property       const TPoint&  Position    = { read = m_Position, write = m_Position   };

__published:
    __property                 int  RoomIndex   = { read = m_RoomIndex, write = SetRoomIndex};
    __property                 int  X           = { read = GetPosition, index = 0           };
    __property                 int  Y           = { read = GetPosition, index = 1           };
          ObjectState   __property  State       = { read = m_State, write = m_State         };
};
//---------------------------------------------------------------------------
class TileDocument : public ImageDocument
{
public:
                        __fastcall  TileDocument(const String& name, const String& extra);
    static  Document*   __fastcall  Create(const String& name, const String& extra) { return new TileDocument(name, extra); };
};
//---------------------------------------------------------------------------
class CharacterSetDocument : public ImageDocument
{
public:
                        __fastcall  CharacterSetDocument(const String& name, const String& extra);
    static  Document*   __fastcall  Create(const String& name, const String& extra) { return new CharacterSetDocument(name, extra); };
};
//---------------------------------------------------------------------------
#endif
