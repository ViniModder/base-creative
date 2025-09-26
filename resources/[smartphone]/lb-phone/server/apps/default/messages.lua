local L0_1, L1_1, L2_1, L3_1
function L0_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2
  L2_2 = MySQL
  L2_2 = L2_2.scalar
  L2_2 = L2_2.await
  L3_2 = [[
        SELECT c.id FROM phone_message_channels c
        WHERE c.is_group = 0
            AND EXISTS (SELECT TRUE FROM phone_message_members m WHERE m.channel_id = c.id AND m.phone_number = ?)
            AND EXISTS (SELECT TRUE FROM phone_message_members m WHERE m.channel_id = c.id AND m.phone_number = ?)
    ]]
  L4_2 = {}
  L5_2 = A0_2
  L6_2 = A1_2
  L4_2[1] = L5_2
  L4_2[2] = L6_2
  return L2_2(L3_2, L4_2)
end
function L1_1(A0_2, A1_2, A2_2, A3_2, A4_2, A5_2)
  local L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2
  if not (A5_2 or A1_2) or not A0_2 then
    return
  end
  if not A2_2 then
    if A3_2 then
      L6_2 = #A3_2
      if 0 ~= L6_2 then
        goto lbl_19
      end
    end
    L6_2 = debugprint
    L7_2 = "No message or attachments provided"
    L6_2(L7_2)
    return
  end
  ::lbl_19::
  if A2_2 then
    L6_2 = #A2_2
    if 0 ~= L6_2 then
      goto lbl_34
    end
  end
  A2_2 = nil
  if A3_2 then
    L6_2 = #A3_2
    if 0 ~= L6_2 then
      goto lbl_34
    end
  end
  L6_2 = debugprint
  L7_2 = "No attachments provided"
  L6_2(L7_2)
  do return end
  ::lbl_34::
  if not A5_2 then
    L6_2 = L0_1
    L7_2 = A0_2
    L8_2 = A1_2
    L6_2 = L6_2(L7_2, L8_2)
    A5_2 = L6_2
  end
  L6_2 = GetSourceFromNumber
  L7_2 = A0_2
  L6_2 = L6_2(L7_2)
  if not A5_2 then
    L7_2 = MySQL
    L7_2 = L7_2.insert
    L7_2 = L7_2.await
    L8_2 = "INSERT INTO phone_message_channels (is_group) VALUES (0)"
    L7_2 = L7_2(L8_2)
    A5_2 = L7_2
    L7_2 = MySQL
    L7_2 = L7_2.update
    L7_2 = L7_2.await
    L8_2 = "INSERT INTO phone_message_members (channel_id, phone_number) VALUES (?, ?), (?, ?)"
    L9_2 = {}
    L10_2 = A5_2
    L11_2 = A0_2
    L12_2 = A5_2
    L13_2 = A1_2
    L9_2[1] = L10_2
    L9_2[2] = L11_2
    L9_2[3] = L12_2
    L9_2[4] = L13_2
    L7_2(L8_2, L9_2)
    L7_2 = GetSourceFromNumber
    L8_2 = A1_2
    L7_2 = L7_2(L8_2)
    if L6_2 then
      L8_2 = TriggerClientEvent
      L9_2 = "phone:messages:newChannel"
      L10_2 = L6_2
      L11_2 = {}
      L11_2.id = A5_2
      L11_2.lastMessage = A2_2
      L12_2 = os
      L12_2 = L12_2.time
      L12_2 = L12_2()
      L12_2 = L12_2 * 1000
      L11_2.timestamp = L12_2
      L11_2.number = A1_2
      L11_2.isGroup = false
      L11_2.unread = false
      L8_2(L9_2, L10_2, L11_2)
    end
    if L7_2 then
      L8_2 = TriggerClientEvent
      L9_2 = "phone:messages:newChannel"
      L10_2 = L7_2
      L11_2 = {}
      L11_2.id = A5_2
      L11_2.lastMessage = A2_2
      L12_2 = os
      L12_2 = L12_2.time
      L12_2 = L12_2()
      L12_2 = L12_2 * 1000
      L11_2.timestamp = L12_2
      L11_2.number = A0_2
      L11_2.isGroup = false
      L11_2.unread = true
      L8_2(L9_2, L10_2, L11_2)
    end
  end
  if L6_2 then
    L7_2 = Log
    L8_2 = "Messages"
    L9_2 = L6_2
    L10_2 = "info"
    L11_2 = L
    L12_2 = "BACKEND.LOGS.MESSAGE_TITLE"
    L11_2 = L11_2(L12_2)
    L12_2 = L
    L13_2 = "BACKEND.LOGS.NEW_MESSAGE"
    L14_2 = {}
    L15_2 = FormatNumber
    L16_2 = A0_2
    L15_2 = L15_2(L16_2)
    L14_2.sender = L15_2
    L15_2 = FormatNumber
    L16_2 = A1_2
    L15_2 = L15_2(L16_2)
    L14_2.recipient = L15_2
    L15_2 = A2_2 or L15_2
    if not A2_2 then
      L15_2 = "Attachment"
    end
    L14_2.message = L15_2
    L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2 = L12_2(L13_2, L14_2)
    L7_2(L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2)
  end
  L7_2 = type
  L8_2 = A3_2
  L7_2 = L7_2(L8_2)
  if "table" == L7_2 then
    L7_2 = json
    L7_2 = L7_2.encode
    L8_2 = A3_2
    L7_2 = L7_2(L8_2)
    A3_2 = L7_2
  end
  L7_2 = MySQL
  L7_2 = L7_2.insert
  L7_2 = L7_2.await
  L8_2 = "INSERT INTO phone_message_messages (channel_id, sender, content, attachments) VALUES (@channelId, @sender, @content, @attachments)"
  L9_2 = {}
  L9_2["@channelId"] = A5_2
  L9_2["@sender"] = A0_2
  L9_2["@content"] = A2_2
  L9_2["@attachments"] = A3_2
  L7_2 = L7_2(L8_2, L9_2)
  if not L7_2 then
    if A4_2 then
      L8_2 = A4_2
      L9_2 = false
      L8_2(L9_2)
    end
    return
  end
  L8_2 = MySQL
  L8_2 = L8_2.update
  L9_2 = "UPDATE phone_message_channels SET last_message = ? WHERE id = ?"
  L10_2 = {}
  L11_2 = string
  L11_2 = L11_2.sub
  L12_2 = A2_2 or L12_2
  if not A2_2 then
    L12_2 = "Attachment"
  end
  L13_2 = 1
  L14_2 = 50
  L11_2 = L11_2(L12_2, L13_2, L14_2)
  L12_2 = A5_2
  L10_2[1] = L11_2
  L10_2[2] = L12_2
  L8_2(L9_2, L10_2)
  L8_2 = MySQL
  L8_2 = L8_2.update
  L9_2 = "UPDATE phone_message_members SET unread = unread + 1 WHERE channel_id = ? AND phone_number != ?"
  L10_2 = {}
  L11_2 = A5_2
  L12_2 = A0_2
  L10_2[1] = L11_2
  L10_2[2] = L12_2
  L8_2(L9_2, L10_2)
  L8_2 = MySQL
  L8_2 = L8_2.update
  L9_2 = "UPDATE phone_message_members SET deleted = 0 WHERE channel_id = ?"
  L10_2 = {}
  L11_2 = A5_2
  L10_2[1] = L11_2
  L8_2(L9_2, L10_2)
  L8_2 = MySQL
  L8_2 = L8_2.query
  L8_2 = L8_2.await
  L9_2 = "SELECT phone_number FROM phone_message_members WHERE channel_id = ? AND phone_number != ?"
  L10_2 = {}
  L11_2 = A5_2
  L12_2 = A0_2
  L10_2[1] = L11_2
  L10_2[2] = L12_2
  L8_2 = L8_2(L9_2, L10_2)
  L9_2 = 1
  L10_2 = #L8_2
  L11_2 = 1
  for L12_2 = L9_2, L10_2, L11_2 do
    L13_2 = L8_2[L12_2]
    L13_2 = L13_2.phone_number
    if L13_2 == A0_2 then
    else
      L14_2 = GetSourceFromNumber
      L15_2 = L13_2
      L14_2 = L14_2(L15_2)
      if L14_2 then
        L15_2 = TriggerClientEvent
        L16_2 = "phone:messages:newMessage"
        L17_2 = L14_2
        L18_2 = A5_2
        L19_2 = L7_2
        L20_2 = A0_2
        L21_2 = A2_2
        L22_2 = A3_2
        L15_2(L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2)
      end
      if "<!CALL-NO-ANSWER!>" == A2_2 then
      else
        L15_2 = GetContact
        L16_2 = A0_2
        L17_2 = L13_2
        L15_2 = L15_2(L16_2, L17_2)
        L16_2 = SendNotification
        L17_2 = L13_2
        L18_2 = {}
        L18_2.app = "Messages"
        L19_2 = L15_2
        if L19_2 then
          L19_2 = L19_2.name
        end
        if not L19_2 then
          L19_2 = A0_2
        end
        L18_2.title = L19_2
        L18_2.content = A2_2
        L19_2 = A3_2 or L19_2
        if A3_2 then
          L19_2 = json
          L19_2 = L19_2.decode
          L20_2 = A3_2
          L19_2 = L19_2(L20_2)
          L19_2 = L19_2[1]
        end
        L18_2.thumbnail = L19_2
        L19_2 = L15_2
        if L19_2 then
          L19_2 = L19_2.avatar
        end
        L18_2.avatar = L19_2
        L18_2.showAvatar = true
        L16_2(L17_2, L18_2)
      end
    end
  end
  if A4_2 then
    L9_2 = A4_2
    L10_2 = A5_2
    L9_2(L10_2)
  end
  L9_2 = TriggerEvent
  L10_2 = "lb-phone:messages:messageSent"
  L11_2 = {}
  L11_2.channelId = A5_2
  L11_2.messageId = L7_2
  L11_2.sender = A0_2
  L11_2.recipient = A1_2
  L11_2.message = A2_2
  L11_2.attachments = A3_2
  L9_2(L10_2, L11_2)
  L9_2 = {}
  L9_2.channelId = A5_2
  L9_2.messageId = L7_2
  return L9_2
end
SendMessage = L1_1
L1_1 = exports
L2_1 = "SentMoney"
function L3_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L3_2 = assert
  L4_2 = type
  L5_2 = A0_2
  L4_2 = L4_2(L5_2)
  L4_2 = "string" == L4_2
  L5_2 = "Expected string for argument 1, got "
  L6_2 = type
  L7_2 = A0_2
  L6_2 = L6_2(L7_2)
  L5_2 = L5_2 .. L6_2
  L3_2(L4_2, L5_2)
  L3_2 = assert
  L4_2 = type
  L5_2 = A1_2
  L4_2 = L4_2(L5_2)
  L4_2 = "string" == L4_2
  L5_2 = "Expected string for argument 2, got "
  L6_2 = type
  L7_2 = A1_2
  L6_2 = L6_2(L7_2)
  L5_2 = L5_2 .. L6_2
  L3_2(L4_2, L5_2)
  L3_2 = assert
  L4_2 = type
  L5_2 = A2_2
  L4_2 = L4_2(L5_2)
  L4_2 = "number" == L4_2
  L5_2 = "Expected number for argument 3, got "
  L6_2 = type
  L7_2 = A2_2
  L6_2 = L6_2(L7_2)
  L5_2 = L5_2 .. L6_2
  L3_2(L4_2, L5_2)
  L3_2 = SendMessage
  L4_2 = A0_2
  L5_2 = A1_2
  L6_2 = "<!SENT-PAYMENT-"
  L7_2 = math
  L7_2 = L7_2.floor
  L8_2 = A2_2 + 0.5
  L7_2 = L7_2(L8_2)
  L8_2 = "!>"
  L6_2 = L6_2 .. L7_2 .. L8_2
  L3_2(L4_2, L5_2, L6_2)
end
L1_1(L2_1, L3_1)
L1_1 = exports
L2_1 = "SendCoords"
function L3_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
  L3_2 = assert
  L4_2 = type
  L5_2 = A0_2
  L4_2 = L4_2(L5_2)
  L4_2 = "string" == L4_2
  L5_2 = "Expected string for argument 1, got "
  L6_2 = type
  L7_2 = A0_2
  L6_2 = L6_2(L7_2)
  L5_2 = L5_2 .. L6_2
  L3_2(L4_2, L5_2)
  L3_2 = assert
  L4_2 = type
  L5_2 = A1_2
  L4_2 = L4_2(L5_2)
  L4_2 = "string" == L4_2
  L5_2 = "Expected string for argument 2, got "
  L6_2 = type
  L7_2 = A1_2
  L6_2 = L6_2(L7_2)
  L5_2 = L5_2 .. L6_2
  L3_2(L4_2, L5_2)
  L3_2 = assert
  L4_2 = type
  L5_2 = A2_2
  L4_2 = L4_2(L5_2)
  L4_2 = "vector2" == L4_2
  L5_2 = "Expected vector2 for argument 3, got "
  L6_2 = type
  L7_2 = A2_2
  L6_2 = L6_2(L7_2)
  L5_2 = L5_2 .. L6_2
  L3_2(L4_2, L5_2)
  L3_2 = SendMessage
  L4_2 = A0_2
  L5_2 = A1_2
  L6_2 = "<!SENT-LOCATION-X="
  L7_2 = A2_2.x
  L8_2 = "Y="
  L9_2 = A2_2.y
  L10_2 = "!>"
  L6_2 = L6_2 .. L7_2 .. L8_2 .. L9_2 .. L10_2
  L3_2(L4_2, L5_2, L6_2)
end
L1_1(L2_1, L3_1)
L1_1 = exports
L2_1 = "SendMessage"
function L3_1(A0_2, A1_2, A2_2, A3_2, A4_2, A5_2)
  local L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2
  L6_2 = assert
  L7_2 = type
  L8_2 = A0_2
  L7_2 = L7_2(L8_2)
  L7_2 = "string" == L7_2
  L8_2 = "Expected string for argument 1, got "
  L9_2 = type
  L10_2 = A0_2
  L9_2 = L9_2(L10_2)
  L8_2 = L8_2 .. L9_2
  L6_2(L7_2, L8_2)
  L6_2 = assert
  L7_2 = type
  L8_2 = A1_2
  L7_2 = L7_2(L8_2)
  L7_2 = "string" == L7_2
  L8_2 = "Expected string or nil for argument 2, got "
  L9_2 = type
  L10_2 = A1_2
  L9_2 = L9_2(L10_2)
  L8_2 = L8_2 .. L9_2
  L6_2(L7_2, L8_2)
  L6_2 = assert
  L7_2 = type
  L8_2 = A2_2
  L7_2 = L7_2(L8_2)
  L7_2 = "string" == L7_2
  L8_2 = "Expected string or nil for argument 3, got "
  L9_2 = type
  L10_2 = A2_2
  L9_2 = L9_2(L10_2)
  L8_2 = L8_2 .. L9_2
  L6_2(L7_2, L8_2)
  L6_2 = assert
  L7_2 = type
  L8_2 = A3_2
  L7_2 = L7_2(L8_2)
  L7_2 = "table" == L7_2
  L8_2 = "Expected table, string or nil for argument 4, got "
  L9_2 = type
  L10_2 = A3_2
  L9_2 = L9_2(L10_2)
  L8_2 = L8_2 .. L9_2
  L6_2(L7_2, L8_2)
  L6_2 = assert
  L7_2 = type
  L8_2 = A4_2
  L7_2 = L7_2(L8_2)
  L7_2 = "function" == L7_2
  L8_2 = "Expected function or nil for argument 5, got "
  L9_2 = type
  L10_2 = A4_2
  L9_2 = L9_2(L10_2)
  L8_2 = L8_2 .. L9_2
  L6_2(L7_2, L8_2)
  L6_2 = SendMessage
  L7_2 = A0_2
  L8_2 = A1_2
  L9_2 = A2_2
  L10_2 = A3_2
  L11_2 = A4_2
  L12_2 = A5_2
  return L6_2(L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)
end
L1_1(L2_1, L3_1)
L1_1 = BaseCallback
L2_1 = "messages:sendMessage"
function L3_1(A0_2, A1_2, A2_2, A3_2, A4_2, A5_2)
  local L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2
  L6_2 = ContainsBlacklistedWord
  L7_2 = A0_2
  L8_2 = "Messages"
  L9_2 = A3_2
  L6_2 = L6_2(L7_2, L8_2, L9_2)
  if L6_2 then
    L6_2 = false
    return L6_2
  end
  L6_2 = SendMessage
  L7_2 = A1_2
  L8_2 = A2_2
  L9_2 = A3_2
  L10_2 = A4_2
  L11_2 = nil
  L12_2 = A5_2
  return L6_2(L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)
end
L1_1(L2_1, L3_1)
L1_1 = BaseCallback
L2_1 = "messages:createGroup"
function L3_1(A0_2, A1_2, A2_2, A3_2, A4_2)
  local L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2
  L5_2 = MySQL
  L5_2 = L5_2.insert
  L5_2 = L5_2.await
  L6_2 = "INSERT INTO phone_message_channels (is_group) VALUES (1)"
  L5_2 = L5_2(L6_2)
  if not L5_2 then
    L6_2 = false
    return L6_2
  end
  L6_2 = {}
  L7_2 = {}
  L7_2.number = A1_2
  L7_2.isOwner = true
  L6_2[1] = L7_2
  L7_2 = MySQL
  L7_2 = L7_2.update
  L7_2 = L7_2.await
  L8_2 = "INSERT INTO phone_message_members (channel_id, phone_number, is_owner) VALUES (?, ?, 1)"
  L9_2 = {}
  L10_2 = L5_2
  L11_2 = A1_2
  L9_2[1] = L10_2
  L9_2[2] = L11_2
  L7_2(L8_2, L9_2)
  L7_2 = 1
  L8_2 = #A2_2
  L9_2 = 1
  for L10_2 = L7_2, L8_2, L9_2 do
    L11_2 = A2_2[L10_2]
    L12_2 = MySQL
    L12_2 = L12_2.update
    L12_2 = L12_2.await
    L13_2 = "INSERT INTO phone_message_members (channel_id, phone_number, is_owner) VALUES (?, ?, 0)"
    L14_2 = {}
    L15_2 = L5_2
    L16_2 = L11_2
    L14_2[1] = L15_2
    L14_2[2] = L16_2
    L12_2(L13_2, L14_2)
    L12_2 = L10_2 + 1
    L13_2 = {}
    L13_2.number = L11_2
    L13_2.isOwner = false
    L6_2[L12_2] = L13_2
  end
  L7_2 = {}
  L7_2.id = L5_2
  L7_2.lastMessage = A3_2
  L8_2 = os
  L8_2 = L8_2.time
  L8_2 = L8_2()
  L8_2 = L8_2 * 1000
  L7_2.timestamp = L8_2
  L7_2.name = nil
  L7_2.isGroup = true
  L7_2.members = L6_2
  L7_2.unread = false
  L8_2 = 1
  L9_2 = #A2_2
  L10_2 = 1
  for L11_2 = L8_2, L9_2, L10_2 do
    L12_2 = GetSourceFromNumber
    L13_2 = A2_2[L11_2]
    L12_2 = L12_2(L13_2)
    if L12_2 then
      L13_2 = TriggerClientEvent
      L14_2 = "phone:messages:newChannel"
      L15_2 = L12_2
      L16_2 = L7_2
      L13_2(L14_2, L15_2, L16_2)
    end
  end
  L8_2 = TriggerClientEvent
  L9_2 = "phone:messages:newChannel"
  L10_2 = A0_2
  L11_2 = L7_2
  L8_2(L9_2, L10_2, L11_2)
  L8_2 = SendMessage
  L9_2 = A1_2
  L10_2 = nil
  L11_2 = A3_2
  L12_2 = A4_2
  L13_2 = nil
  L14_2 = L5_2
  return L8_2(L9_2, L10_2, L11_2, L12_2, L13_2, L14_2)
end
L1_1(L2_1, L3_1)
L1_1 = BaseCallback
L2_1 = "messages:renameGroup"
function L3_1(A0_2, A1_2, A2_2, A3_2)
  local L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L4_2 = MySQL
  L4_2 = L4_2.update
  L4_2 = L4_2.await
  L5_2 = "UPDATE phone_message_channels SET `name` = ? WHERE id = ? AND is_group = 1"
  L6_2 = {}
  L7_2 = A3_2
  L8_2 = A2_2
  L6_2[1] = L7_2
  L6_2[2] = L8_2
  L4_2 = L4_2(L5_2, L6_2)
  L4_2 = L4_2 > 0
  if L4_2 then
    L5_2 = TriggerClientEvent
    L6_2 = "phone:messages:renameGroup"
    L7_2 = -1
    L8_2 = A2_2
    L9_2 = A3_2
    L5_2(L6_2, L7_2, L8_2, L9_2)
  end
  return L4_2
end
L1_1(L2_1, L3_1)
L1_1 = BaseCallback
L2_1 = "messages:getRecentMessages"
function L3_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2
  L2_2 = MySQL
  L2_2 = L2_2.query
  L2_2 = L2_2.await
  L3_2 = [[
        SELECT
            channel.id AS channel_id,
            channel.is_group,
            channel.`name`,
            channel.last_message,
            channel.last_message_timestamp,
            channel_member.phone_number,
            channel_member.is_owner,
            channel_member.unread,
            channel_member.deleted
        FROM
            phone_message_members target_member

        INNER JOIN phone_message_channels channel
            ON channel.id = target_member.channel_id

        INNER JOIN phone_message_members channel_member
            ON channel_member.channel_id = channel.id

        WHERE
            target_member.phone_number = ?

        ORDER BY
            channel.last_message_timestamp DESC
    ]]
  L4_2 = {}
  L5_2 = A1_2
  L4_2[1] = L5_2
  return L2_2(L3_2, L4_2)
end
L1_1(L2_1, L3_1)
L1_1 = BaseCallback
L2_1 = "messages:getMessages"
function L3_1(A0_2, A1_2, A2_2, A3_2)
  local L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
  L4_2 = MySQL
  L4_2 = L4_2.query
  L4_2 = L4_2.await
  L5_2 = [[
        SELECT id, sender, content, attachments, `timestamp`
        FROM phone_message_messages

        WHERE channel_id = ? AND EXISTS (SELECT TRUE FROM phone_message_members m WHERE m.channel_id = ? AND m.phone_number = ?)

        ORDER BY `timestamp` DESC
        LIMIT ?, ?
    ]]
  L6_2 = {}
  L7_2 = A2_2
  L8_2 = A2_2
  L9_2 = A1_2
  L10_2 = A3_2 * 25
  L11_2 = 25
  L6_2[1] = L7_2
  L6_2[2] = L8_2
  L6_2[3] = L9_2
  L6_2[4] = L10_2
  L6_2[5] = L11_2
  return L4_2(L5_2, L6_2)
end
L1_1(L2_1, L3_1)
L1_1 = BaseCallback
L2_1 = "messages:deleteMessage"
function L3_1(A0_2, A1_2, A2_2, A3_2)
  local L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
  L4_2 = Config
  L4_2 = L4_2.DeleteMessages
  if not L4_2 then
    L4_2 = false
    return L4_2
  end
  L4_2 = MySQL
  L4_2 = L4_2.scalar
  L4_2 = L4_2.await
  L5_2 = "SELECT MAX(id) FROM phone_message_messages WHERE channel_id = ?"
  L6_2 = {}
  L7_2 = A3_2
  L6_2[1] = L7_2
  L4_2 = L4_2(L5_2, L6_2)
  L4_2 = L4_2 == A2_2
  L5_2 = MySQL
  L5_2 = L5_2.update
  L5_2 = L5_2.await
  L6_2 = "DELETE FROM phone_message_messages WHERE id = ? AND sender = ? AND channel_id = ?"
  L7_2 = {}
  L8_2 = A2_2
  L9_2 = A1_2
  L10_2 = A3_2
  L7_2[1] = L8_2
  L7_2[2] = L9_2
  L7_2[3] = L10_2
  L5_2 = L5_2(L6_2, L7_2)
  L5_2 = L5_2 > 0
  if L5_2 and L4_2 then
    L6_2 = MySQL
    L6_2 = L6_2.update
    L6_2 = L6_2.await
    L7_2 = "UPDATE phone_message_channels SET last_message = ? WHERE id = ?"
    L8_2 = {}
    L9_2 = L
    L10_2 = "APPS.MESSAGES.MESSAGE_DELETED"
    L9_2 = L9_2(L10_2)
    L10_2 = A3_2
    L8_2[1] = L9_2
    L8_2[2] = L10_2
    L6_2(L7_2, L8_2)
  end
  if L5_2 then
    L6_2 = TriggerClientEvent
    L7_2 = "phone:messages:messageDeleted"
    L8_2 = -1
    L9_2 = A3_2
    L10_2 = A2_2
    L11_2 = L4_2
    L6_2(L7_2, L8_2, L9_2, L10_2, L11_2)
  end
  return L5_2
end
L1_1(L2_1, L3_1)
L1_1 = BaseCallback
L2_1 = "messages:addMember"
function L3_1(A0_2, A1_2, A2_2, A3_2)
  local L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2
  L4_2 = MySQL
  L4_2 = L4_2.update
  L4_2 = L4_2.await
  L5_2 = "INSERT IGNORE INTO phone_message_members (channel_id, phone_number) VALUES (?, ?)"
  L6_2 = {}
  L7_2 = A2_2
  L8_2 = A3_2
  L6_2[1] = L7_2
  L6_2[2] = L8_2
  L4_2 = L4_2(L5_2, L6_2)
  L4_2 = L4_2 > 0
  L5_2 = GetSourceFromNumber
  L6_2 = A3_2
  L5_2 = L5_2(L6_2)
  if not L4_2 then
    L6_2 = false
    return L6_2
  end
  L6_2 = TriggerClientEvent
  L7_2 = "phone:messages:memberAdded"
  L8_2 = -1
  L9_2 = A2_2
  L10_2 = A3_2
  L6_2(L7_2, L8_2, L9_2, L10_2)
  if not L5_2 then
    L6_2 = true
    return L6_2
  end
  L6_2 = MySQL
  L6_2 = L6_2.Sync
  L6_2 = L6_2.fetchAll
  L7_2 = "SELECT phone_number AS `number`, is_owner AS isOwner FROM phone_message_members WHERE channel_id = ?"
  L8_2 = {}
  L9_2 = A2_2
  L8_2[1] = L9_2
  L6_2 = L6_2(L7_2, L8_2)
  L7_2 = MySQL
  L7_2 = L7_2.single
  L7_2 = L7_2.await
  L8_2 = "SELECT `name`, last_message, last_message_timestamp FROM phone_message_channels WHERE id = ?"
  L9_2 = {}
  L10_2 = A2_2
  L9_2[1] = L10_2
  L7_2 = L7_2(L8_2, L9_2)
  L8_2 = #L6_2
  if L8_2 > 0 and L7_2 then
    L8_2 = TriggerClientEvent
    L9_2 = "phone:messages:newChannel"
    L10_2 = L5_2
    L11_2 = {}
    L11_2.id = A2_2
    L12_2 = L7_2.last_message
    L11_2.lastMessage = L12_2
    L12_2 = L7_2.last_message_timestamp
    L11_2.timestamp = L12_2
    L12_2 = L7_2.name
    L11_2.name = L12_2
    L11_2.isGroup = true
    L11_2.members = L6_2
    L11_2.unread = false
    L8_2(L9_2, L10_2, L11_2)
  end
  L8_2 = true
  return L8_2
end
L1_1(L2_1, L3_1)
L1_1 = BaseCallback
L2_1 = "messages:removeMember"
function L3_1(A0_2, A1_2, A2_2, A3_2)
  local L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
  L4_2 = MySQL
  L4_2 = L4_2.scalar
  L4_2 = L4_2.await
  L5_2 = "SELECT is_owner FROM phone_message_members WHERE channel_id = ? AND phone_number = ?"
  L6_2 = {}
  L7_2 = A2_2
  L8_2 = A1_2
  L6_2[1] = L7_2
  L6_2[2] = L8_2
  L4_2 = L4_2(L5_2, L6_2)
  if not L4_2 then
    L5_2 = false
    return L5_2
  end
  L5_2 = MySQL
  L5_2 = L5_2.update
  L5_2 = L5_2.await
  L6_2 = "DELETE FROM phone_message_members WHERE channel_id = ? AND phone_number = ?"
  L7_2 = {}
  L8_2 = A2_2
  L9_2 = A3_2
  L7_2[1] = L8_2
  L7_2[2] = L9_2
  L5_2 = L5_2(L6_2, L7_2)
  L5_2 = L5_2 > 0
  if L5_2 then
    L6_2 = TriggerClientEvent
    L7_2 = "phone:messages:memberRemoved"
    L8_2 = -1
    L9_2 = A2_2
    L10_2 = A3_2
    L6_2(L7_2, L8_2, L9_2, L10_2)
  end
  return L5_2
end
L1_1(L2_1, L3_1)
L1_1 = BaseCallback
L2_1 = "messages:leaveGroup"
function L3_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
  L3_2 = MySQL
  L3_2 = L3_2.scalar
  L3_2 = L3_2.await
  L4_2 = "SELECT is_owner FROM phone_message_members WHERE channel_id = ? AND phone_number = ?"
  L5_2 = {}
  L6_2 = A2_2
  L7_2 = A1_2
  L5_2[1] = L6_2
  L5_2[2] = L7_2
  L3_2 = L3_2(L4_2, L5_2)
  if L3_2 then
    L4_2 = MySQL
    L4_2 = L4_2.update
    L4_2 = L4_2.await
    L5_2 = [[
            UPDATE phone_message_members m
            SET is_owner = TRUE
            WHERE m.channel_id = ?
            AND m.phone_number != ?
            LIMIT 1
        ]]
    L6_2 = {}
    L7_2 = A2_2
    L8_2 = A1_2
    L6_2[1] = L7_2
    L6_2[2] = L8_2
    L4_2(L5_2, L6_2)
    L4_2 = MySQL
    L4_2 = L4_2.scalar
    L4_2 = L4_2.await
    L5_2 = "SELECT phone_number FROM phone_message_members WHERE channel_id = ? AND is_owner = TRUE"
    L6_2 = {}
    L7_2 = A2_2
    L6_2[1] = L7_2
    L4_2 = L4_2(L5_2, L6_2)
    L5_2 = TriggerClientEvent
    L6_2 = "phone:messages:ownerChanged"
    L7_2 = -1
    L8_2 = A2_2
    L9_2 = L4_2
    L5_2(L6_2, L7_2, L8_2, L9_2)
  end
  L4_2 = MySQL
  L4_2 = L4_2.update
  L4_2 = L4_2.await
  L5_2 = "DELETE FROM phone_message_members WHERE channel_id = ? AND phone_number = ?"
  L6_2 = {}
  L7_2 = A2_2
  L8_2 = A1_2
  L6_2[1] = L7_2
  L6_2[2] = L8_2
  L4_2 = L4_2(L5_2, L6_2)
  L4_2 = L4_2 > 0
  L5_2 = MySQL
  L5_2 = L5_2.scalar
  L5_2 = L5_2.await
  L6_2 = "SELECT COUNT(1) FROM phone_message_members WHERE channel_id = ?"
  L7_2 = {}
  L8_2 = A2_2
  L7_2[1] = L8_2
  L5_2 = L5_2(L6_2, L7_2)
  L5_2 = 0 == L5_2
  if L4_2 then
    L6_2 = TriggerClientEvent
    L7_2 = "phone:messages:memberRemoved"
    L8_2 = -1
    L9_2 = A2_2
    L10_2 = A1_2
    L6_2(L7_2, L8_2, L9_2, L10_2)
  end
  if L5_2 then
    L6_2 = MySQL
    L6_2 = L6_2.update
    L6_2 = L6_2.await
    L7_2 = "DELETE FROM phone_message_channels WHERE id = ?"
    L8_2 = {}
    L9_2 = A2_2
    L8_2[1] = L9_2
    L6_2(L7_2, L8_2)
    L6_2 = debugprint
    L7_2 = "Deleted group "
    L8_2 = A2_2
    L7_2 = L7_2 .. L8_2
    L8_2 = "due to it being empty"
    L6_2(L7_2, L8_2)
  end
  return L4_2
end
L1_1(L2_1, L3_1)
L1_1 = BaseCallback
L2_1 = "messages:markRead"
function L3_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2
  L3_2 = MySQL
  L3_2 = L3_2.update
  L3_2 = L3_2.await
  L4_2 = "UPDATE phone_message_members SET unread = 0 WHERE channel_id = ? AND phone_number = ?"
  L5_2 = {}
  L6_2 = A2_2
  L7_2 = A1_2
  L5_2[1] = L6_2
  L5_2[2] = L7_2
  L3_2(L4_2, L5_2)
  L3_2 = true
  return L3_2
end
L1_1(L2_1, L3_1)
L1_1 = BaseCallback
L2_1 = "messages:deleteConversations"
function L3_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2
  L3_2 = type
  L4_2 = A2_2
  L3_2 = L3_2(L4_2)
  if "table" ~= L3_2 then
    L3_2 = debugprint
    L4_2 = "expected table, got "
    L5_2 = type
    L6_2 = A2_2
    L5_2 = L5_2(L6_2)
    L4_2 = L4_2 .. L5_2
    L3_2(L4_2)
    L3_2 = false
    return L3_2
  end
  L3_2 = MySQL
  L3_2 = L3_2.update
  L3_2 = L3_2.await
  L4_2 = "UPDATE phone_message_members SET deleted = 1 WHERE channel_id IN (?) AND phone_number = ?"
  L5_2 = {}
  L6_2 = A2_2
  L7_2 = A1_2
  L5_2[1] = L6_2
  L5_2[2] = L7_2
  L3_2(L4_2, L5_2)
  L3_2 = true
  return L3_2
end
L1_1(L2_1, L3_1)
